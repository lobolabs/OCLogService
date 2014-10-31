//
//  OCBaseLogger.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCBaseLogger.h"
#import "OCLogObject.h"
#import "OCLogObject_Protected.h"
#import "NSObject+Autodescription.h"

@implementation OCBaseLogger

#pragma mark - Public methods

- (NSString *)baseObjectRepresentation:(OCLogObject *)logObject
{
    return [logObject logDescription];
}

@end
