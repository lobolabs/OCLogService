//
//  OCLogFiller.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCLogFiller.h"
#import "OCLogObject_Protected.h"

@implementation OCLogFiller

#pragma mark - Public methods

- (void)fillLogObject:(OCLogObject *)log
{
    [log setLogTime:[NSDate date]];
}

@end
