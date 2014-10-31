//
//  OCFileLogger.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCFileLogger.h"
#import "OCLogObject.h"
#import "OCLogObjectFilePrinter.h"

@interface OCFileLogger()
{
    BOOL isFirstPost;
    
    dispatch_io_t channel;
    dispatch_queue_t queue;
    dispatch_semaphore_t semaphore;
    
    BOOL writing;
    off_t offset;
    dispatch_data_t dispatchData;
    
    NSMutableArray *logBuffer;
}

@property (atomic, strong) NSMutableArray *logBuffer;

+ (NSString *)filePath;

@end;

@implementation OCFileLogger

@synthesize logBuffer = logBuffer;

- (instancetype)init
{
    if (self = [super init])
    {
        isFirstPost = true;
        queue = dispatch_queue_create("OCFielLogger_Queue", DISPATCH_QUEUE_SERIAL);
        semaphore = dispatch_semaphore_create(1);
        
        logBuffer = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)log:(OCLogObject *)logObject
{
    if (isFirstPost) {
        [self createFile];
    }
    NSString *logString;
    if ([logObject conformsToProtocol:@protocol(OCLogObjectFilePrinter)]) {
        logString = [(id<OCLogObjectFilePrinter>)logObject filePrint];
    }
    logString = [self baseObjectRepresentation:logObject];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    if (writing){
        [[self logBuffer] addObject:logString];
    }
    else {
        [self pushToFile:[logString UTF8String] len:[logString length]];
        writing = YES;
    }
    dispatch_semaphore_signal(semaphore);
}

- (void)pushToFile:(const char*)stringData len:(int)length
{
    dispatchData = dispatch_data_create(stringData, length * sizeof(char), queue, DISPATCH_DATA_DESTRUCTOR_DEFAULT);
    dispatch_io_write(channel, offset, dispatchData, queue, ^(bool done, dispatch_data_t data, int error) {
        if (done) {
            offset += length * sizeof(char);
            dispatch_semaphore_wait(semaphore, 2);
            writing = [self tryStartNextLog];
            dispatch_semaphore_signal(semaphore);
        }
        else {
            [self pushToFile:stringData len:length];
        }
    });
}

- (BOOL)tryStartNextLog
{
    if ([[self logBuffer] count]) {
        NSString *log = [[self logBuffer] objectAtIndex:0];
        [self pushToFile:[log UTF8String] len:[log length]];
        return YES;
    }
    return NO;
}

- (void)createFile
{
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    if (isFirstPost) {
        NSString *filePath = [[self class] filePath];
        channel = dispatch_io_create_with_path(DISPATCH_IO_STREAM, [filePath UTF8String], O_WRONLY|O_APPEND|O_CREAT, S_IREAD|S_IWRITE, queue, ^(int error){});
        isFirstPost = false;
    }
    dispatch_semaphore_signal(semaphore);
}

+ (NSString *)filePath
{
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss' '"];
    NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];
    return  [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"OCLog %@.txt", timeString]];
}

@end
