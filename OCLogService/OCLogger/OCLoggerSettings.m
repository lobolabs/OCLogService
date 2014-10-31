//
//  OCLoggerSettings.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCLoggerSettings.h"

NSString *const kOCLoggerSettings_keepLogSavedTimeKey              = @"OCLogService.KeepLogAvailableTime";
NSString *const kOCLoggerSettings_logToConsoleKey                  = @"OCLogService.LogToConsole";
NSString *const kOCLoggerSettings_logToFileKey                     = @"OCLogService.LogToFile";
NSString *const kOCLoggerSettings_lotToService                     = @"OCLogService.LogToService";
NSString *const kOCLoggerSettings_flushToServerAutomaticallyKey    = @"OCLogService.FlushToServerAutomatically";
NSString *const kOCLoggerSettings_serverUrlKey                     = @"OCLogService.ServerURL";



@interface OCLoggerSettings()
{
    NSTimeInterval keepLogSavedTimeInterval;
    BOOL logToConsole;
    BOOL logToFile;
    BOOL logToService;
    BOOL flushToServerAutomatically;
    NSString *serverUrl;
}

@end

@implementation OCLoggerSettings

#pragma mark - Instantiation

+ (instancetype)initWithFile:(NSString *)fileName
{
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:path]];
    if (!dict) return nil;
    
    return [[self alloc] initWithDictionary:dict];;
}

#pragma mark - Instantiating with dictionary

- (id)initWithDictionary:(NSDictionary *)aDict;
{
    if (self = [super init])
    {
        NSNumber *keepLogSavedNumber                = [aDict objectForKey:kOCLoggerSettings_keepLogSavedTimeKey];
        NSNumber *logToConsoleNumber                = [aDict objectForKey:kOCLoggerSettings_logToConsoleKey];
        NSNumber *logToFileNumber                   = [aDict objectForKey:kOCLoggerSettings_logToFileKey];
        NSNumber *logToServiceNumber                = [aDict objectForKey:kOCLoggerSettings_lotToService];
        NSNumber *flushToServerAutomaticallyNumber  = [aDict objectForKey:kOCLoggerSettings_flushToServerAutomaticallyKey];
        NSString *serverUrlString                   = [aDict objectForKey:kOCLoggerSettings_serverUrlKey];
        
        NSAssert2(keepLogSavedNumber,               @"Settings should contain key: |%@| as |%@|", kOCLoggerSettings_keepLogSavedTimeKey, @"double");
        NSAssert2(logToConsoleNumber,               @"Settings should contain key: |%@| as |%@|", kOCLoggerSettings_logToConsoleKey, @"bool");
        NSAssert2(logToFileNumber,                  @"Settings should contain key: |%@| as |%@|", kOCLoggerSettings_logToFileKey, @"bool");
        NSAssert2(logToServiceNumber,               @"Settings should contain key: |%@| as |%@|", kOCLoggerSettings_lotToService, @"bool");
        NSAssert2(flushToServerAutomaticallyNumber, @"Settings should contain key: |%@| as |%@|", kOCLoggerSettings_flushToServerAutomaticallyKey, @"bool");
        NSAssert2(serverUrlString,                  @"Settings should contain key: |%@| as |%@|", kOCLoggerSettings_serverUrlKey, @"string");
        
        keepLogSavedTimeInterval    = [keepLogSavedNumber boolValue];
        logToConsole                = [logToConsoleNumber boolValue];
        logToFile                   = [logToFileNumber boolValue];
        logToService                = [logToServiceNumber boolValue];
        flushToServerAutomatically  = [flushToServerAutomaticallyNumber boolValue];
        serverUrl                   = serverUrlString;
    }
    
    return self;
}

#pragma mark - Public getters

- (NSTimeInterval)keepLogAvailableInterval
{
    return keepLogSavedTimeInterval;
}

- (BOOL)logToFile
{
    return logToFile;
}

- (BOOL)logToConsole
{
    return logToConsole;
}

- (BOOL)logToService
{
    return logToService;
}

- (BOOL)flushLogsToServerAutomatically
{
    return flushToServerAutomatically;
}

- (NSString *)url
{
    return serverUrl;
}

@end
