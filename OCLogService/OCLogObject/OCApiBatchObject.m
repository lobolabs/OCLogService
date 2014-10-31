//
//  OCApiBatchObject.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/23/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCApiBatchObject.h"

@implementation OCApiBatchObject

#pragma mark - JSONModel setup

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return ![propertyName isEqualToString:@"client_id"];
}

@end
