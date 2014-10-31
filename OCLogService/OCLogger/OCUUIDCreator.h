//
//  OCUUIDCreator.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/23/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDefines.h"

@interface OCUUIDCreator : NSObject

- (instancetype)initWithAccountIdenfier:(NSString *)accountIdenfier uuidKeyStorer:(NSString *)uuidKey;
- (instancetype)init ATTR_UNAVAILABLE_MSG("use initWithAccountIdenfier:uuidKeyStorer instead");

- (NSString *)uuid;

@end
