//
//  OCLogServiceConfigurator.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCLogServiceConfigurator : NSObject

/*
 * baseLogObject
 * 
 * class references to basic log object
 * that should be presend in every log
 *
 * should be overrided in subclass
 *
 */
- (Class)baseLogClass;

/* 
 * settingsPlist
 * 
 * should return settings plist file name in main bundle
 *
 * should be overrided in subclass
 *
 */
- (NSString *)settingsPlist;

/*
 * uuidStorereIdentifier
 *
 * identifier for account in keychain
 *
 * should be overrided in subclass
 */
- (NSString *)uuidStorerIdentifier;

/*
 * uuidStorerKey
 *
 * key for storing identificator for log objects in keychain
 *
 * should be overrided in subclass
 *
 */
- (NSString *)uuidStorerKey;

/*
 * batchObject
 *
 * object for posting logs to API contains only properties
 * that never changes
 *
 */
- (Class)batchObject;

@end
