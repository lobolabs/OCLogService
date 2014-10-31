//
//  OCApiBatchObject.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/23/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"


@protocol OCLogObject
@end

/*
 * OCApiBatchObject
 *
 * can be subclassed and containing properties
 * that never changes. These properties should
 * be installed on init method
 *
 */
@interface OCApiBatchObject : JSONModel

@property (nonatomic, strong) NSString *client_id;
@property (nonatomic, strong) NSArray<OCLogObject> *logs;

@end
