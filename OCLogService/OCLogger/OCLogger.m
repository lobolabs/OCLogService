//
//  OCLogger.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCLogger.h"
#import "OCLogServiceConfigurator.h"
#import "OCLoggerSettings.h"
#import "OCLogFiller.h"
#import "OCConsoleLogger.h"
#import "OCFileLogger.h"
#import "OCServiceLogger.h"
#import "OCUUIDCreator.h"

@interface OCLogger()
{
    Class baseLogClass;
    OCLoggerSettings *settings;
    OCLogFiller *logFiller;
    
    OCConsoleLogger *consoleLogger;
    OCFileLogger *fileLogger;
    OCServiceLogger *serviceLogger;
    
    BOOL logToConsole;
    BOOL logToFile;
    BOOL logToService;
}

+ (BOOL)isConfiguratorValid:(OCLogServiceConfigurator *)configurator;

@end

@implementation OCLogger

#pragma mark - Instantiation

- (instancetype)initWithConfigurator:(OCLogServiceConfigurator *)configurator
{
    if (![[self class] isConfiguratorValid:configurator])
        return nil;
    
    OCLoggerSettings *settingsFromPlist = [OCLoggerSettings initWithFile:[configurator settingsPlist]];
    if (!settingsFromPlist)
        return nil;
    
    
    if (self = [super init]) {
        baseLogClass = [configurator baseLogClass];
        settings = settingsFromPlist;
        
        logFiller = [[OCLogFiller alloc] init];
        
        [self createLoggers:configurator];
        [self setupConditionalIvars];
    }
    return self;
}

#pragma mark - Public methods

- (void)log:(id)logObject
{
    [self logToType:OCLogTypeConsole | OCLogTypeFile | OCLogTypeService log:logObject];
}

- (void)logToType:(OCLogType)type log:(id)logObject
{
    if (![self isLogObjectValid:logObject]) {
        NSLog(@"Invalid log object: %@", [logObject description]);
        return;
    }
    
    [logFiller fillLogObject:logObject];
    
    if (logToConsole && (type & OCLogTypeConsole))
        [consoleLogger log:logObject];
    
    if (logToFile && (type & OCLogTypeFile))
        [fileLogger log:logObject];
    
    if (logToService && (type & OCLogTypeService))
        [serviceLogger log:logObject];
}

- (void)flushLogs
{
    [serviceLogger flushLogs];
}

#pragma mark - Private Methods

+ (BOOL)isConfiguratorValid:(OCLogServiceConfigurator *)configurator
{
    return ([configurator baseLogClass] &&
            [[configurator settingsPlist] length] &&
            [[configurator uuidStorerKey] length] &&
            [[configurator uuidStorerIdentifier] length]);
}

- (BOOL)isLogObjectValid:(id)logObject
{
    return [logObject isKindOfClass:baseLogClass];
}

- (void)createLoggers:(OCLogServiceConfigurator *)configurator
{
    if ([settings logToConsole])
        consoleLogger = [[OCConsoleLogger alloc] init];
    
    if ([settings logToFile])
        fileLogger = [[OCFileLogger alloc] init];
    
    if ([settings logToService]) {
        NSString *uuid = [[[OCUUIDCreator alloc] initWithAccountIdenfier:[configurator uuidStorerIdentifier]
                                                           uuidKeyStorer:[configurator uuidStorerKey]] uuid];
        
        serviceLogger = [[OCServiceLogger alloc] initWithUUID:uuid
                                                andBatchClass:[configurator batchObject]
                                                          url:[NSURL URLWithString:[settings url]]];
        
        [serviceLogger setFlushInterval:[settings keepLogAvailableInterval]];
    }
    
}

- (void)setupConditionalIvars
{
    logToConsole = [settings logToConsole];
    logToFile = [settings logToFile];
    logToService = [settings logToService] && [NSURL URLWithString:[settings url]];
}

@end
