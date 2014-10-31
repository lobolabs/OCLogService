//
//  OCLogObject.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

/*
 * OCLogObject
 *
 * base log object
 * you should subclass and add nececarly fields
 * to use logger
 */
@interface OCLogObject : JSONModel

/*
 * dateFormatter
 *
 * dateFormatter that can be overrided
 * in subclass
 *
 */
+ (NSDateFormatter *)dateFormatter;


/*
 * nestedClass
 *
 * class that indicate nested object in log object
 * property. that class will be asked for confirming
 * OCLogObjectProtocol and if it not conform that protocol
 * it will be autodescribed
 *
 */
+ (Class)nestedClass;

@end


/*
 * OCLogObjectProtocol
 *
 * if you put into OCLogObject subclass other object
 * for userfriendly logging you should implement that protocol
 *
 */
@protocol OCLogObjectProtocol <NSObject>

- (NSString *)objectDescription;

@end