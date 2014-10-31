//
//  OCConsoleLogger.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCConsoleLogger.h"
#import "OCLogObject.h"
#import "OCLogObjectConsolePrinter.h"

#include <asl.h>

@implementation OCConsoleLogger

- (void)log:(OCLogObject *)logObject
{
    if (!logObject)
        return;
    
    NSString *logString;
    if ([logObject conformsToProtocol:@protocol(OCLogObjectConsolePrinter)]) {
        logString = [(id<OCLogObjectConsolePrinter>)logObject consolePrint];
    }
    logString = [self baseObjectRepresentation:logObject];
    
    NSLog(@"%@", logString);
}

@end
