//
//  OCLogFiller.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCLogObject;

@interface OCLogFiller : NSObject

- (void)fillLogObject:(OCLogObject *)log;

@end
