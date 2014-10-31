//
//  OCLogger.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDefines.h"

@class OCLogObject;
@class OCLogServiceConfigurator;

typedef NS_ENUM(NSUInteger, OCLogType){
    OCLogTypeConsole =  1 << 0,
    OCLogTypeFile    =  1 << 1,
    OCLogTypeService =  1 << 2
};


@interface OCLogger : NSObject

/*
 * initWithConfigurator:
 * 
 * try to instantiate a new logger. return correct instance if configurator
 * settuped correctly
 */
- (instancetype)initWithConfigurator:(OCLogServiceConfigurator *)configurator;
- (instancetype)init ATTR_UNAVAILABLE_MSG("use initWithConfigurator: instead");

/*
 * log:
 *
 * append to logs new log object if that object is subclass of 
 * base log object. Append to file / console / service logs
 *
 */
- (void)log:(OCLogObject *)logObject;

/*
 *
 * logToType:log:
 *
 * log to some of log types
 *
 */
- (void)logToType:(OCLogType)type log:(OCLogObject *)logObject;

/*
 * flushLogs
 *
 * send all available logs to server
 *
 */
- (void)flushLogs;

@end
