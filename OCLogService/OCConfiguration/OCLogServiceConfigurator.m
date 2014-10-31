//
//  OCLogServiceConfigurator.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCLogServiceConfigurator.h"
#import "OCApiBatchObject.h"

@implementation OCLogServiceConfigurator

- (Class)baseLogClass
{
    return nil;
}

- (NSString *)settingsPlist
{
    return nil;
}

- (NSString *)uuidStorerIdentifier
{
    return nil;
}

- (NSString *)uuidStorerKey
{
    return nil;
}

- (Class)batchObject
{
    return [OCApiBatchObject class];
}

@end
