//
//  OCLoggerSettings.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDefines.h"

@interface OCLoggerSettings : NSObject

+ (instancetype)initWithFile:(NSString *)fileName;
- (instancetype)init ATTR_UNAVAILABLE_MSG("use: initWithFile: instead");

- (NSTimeInterval)keepLogAvailableInterval;
- (BOOL)logToConsole;
- (BOOL)logToFile;
- (BOOL)logToService;
- (BOOL)flushLogsToServerAutomatically;
- (NSString *)url;

@end
