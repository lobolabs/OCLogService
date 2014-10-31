//
//  OCLogObject_Protected.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCLogObject.h"

@interface OCLogObject ()

@property (nonatomic, strong) NSDate *logTime;

- (NSString *)logDescription;

@end
