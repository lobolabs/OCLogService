//
//  OCServiceLogger.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/23/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCServiceLogger.h"
#import "OCApiBatchObject.h"

#import "JSONModel.h"

#import <objc/runtime.h>

@interface OCServiceLogger()
{
    NSString *_uuid;
    NSURL *_url;
    Class _batchClass;
    
    NSMutableArray<OCLogObject> *buffer;
    
    dispatch_semaphore_t semaphore;
    
    NSTimer *timer;
}

@end

@implementation OCServiceLogger

#pragma mark - Instantiation

- (instancetype)initWithUUID:(NSString *)uuid andBatchClass:(__unsafe_unretained Class)batchClass url:(NSURL *)url
{
    if ([uuid length] && batchClass && url && (self = [super init]))
    {
        _uuid = uuid;
        _batchClass = batchClass;
        _url = url;
        
        semaphore = dispatch_semaphore_create(1);
        
        buffer = (NSMutableArray<OCLogObject> *)[[NSMutableArray alloc] initWithCapacity:100];
    }
    return self;
}

#pragma mark - Public methods

- (void)log:(OCLogObject *)logObject
{
    [buffer addObject:logObject];
}

- (void)flushLogs
{
    [self send];
}

- (void)setFlushInterval:(NSTimeInterval)flushInterval
{
    [timer invalidate];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:flushInterval target:self selector:@selector(send) userInfo:nil repeats:YES];
}

#pragma mark - Private methods

- (void)addLogToBuffer:(OCLogObject *)log
{
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [buffer addObject:log];
    dispatch_semaphore_signal(semaphore);
}

- (NSMutableArray<OCLogObject> *)changeBuffer
{
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSMutableArray<OCLogObject> *link = buffer;
    buffer = (NSMutableArray<OCLogObject> *)[[NSMutableArray alloc] init];
    dispatch_semaphore_signal(semaphore);
    return link;
}

- (void)send
{
    OCApiBatchObject *batch = [self makeBatch];
    
    if ([[batch logs] count]) {
        [self sendToServer:batch];
    }
}

- (OCApiBatchObject *)makeBatch
{
    NSMutableArray<OCLogObject> *logs = [self changeBuffer];
    
    OCApiBatchObject *batch = [[_batchClass alloc] init];
    [batch setClient_id:_uuid];
    [batch setLogs:logs];
    
    return batch;
}

- (NSURLRequest *)makeRequest:(OCApiBatchObject *)batch
{
    NSData *postData = [[batch toJSONString] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *bodyLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:_url];
    [request setHTTPMethod:@"POST"];
    [request setValue:bodyLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    return request;
}

- (void)sendToServer:(OCApiBatchObject *)batch
{
    NSURLRequest *request = [self makeRequest:batch];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if ([(NSHTTPURLResponse *)response statusCode] == 200) {
            
        }
        else {
            [self sendToServer:batch];
        }
    }];
}

@end
