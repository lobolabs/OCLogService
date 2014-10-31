//
//  OCUUIDCreator.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/23/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCUUIDCreator.h"

#import "KeychainItemWrapper.h"

@interface OCUUIDCreator()
{
    NSString *uuidString;
}

+ (NSString *)tryRestoreUuidForKey:(NSString *)key inKeychainItem:(KeychainItemWrapper *)keychainWrapper;
+ (void)saveUuid:(NSString *)uuid forKey:(NSString *)key inKeychainItem:(KeychainItemWrapper *)keychainWrapper;
+ (NSString *)createUuidKey;

@end

@implementation OCUUIDCreator

#pragma mark - Instantiation

- (instancetype)initWithAccountIdenfier:(NSString *)accountIdenfier uuidKeyStorer:(NSString *)uuidKey
{
    if (uuidKey.length && accountIdenfier.length && (self = [super init])) {
        KeychainItemWrapper *keychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:accountIdenfier accessGroup:nil];
        
        NSString *uuid = [[self class] tryRestoreUuidForKey:uuidKey inKeychainItem:keychainWrapper];
        if (!uuid.length) {
            uuid = [[self class] createUuidKey];
            [[self class] saveUuid:uuid forKey:uuidKey inKeychainItem:keychainWrapper];
        }
        NSAssert(uuid, @"UUID make failed");
        uuidString = uuid;
    }
    return self;
}

#pragma mark - Public methods

- (NSString *)uuid
{
    return uuidString;
}

#pragma mark - Private methods

+ (NSString *)tryRestoreUuidForKey:(NSString *)key inKeychainItem:(KeychainItemWrapper *)keychainWrapper
{
    return [keychainWrapper objectForKey:(__bridge id)kSecValueData];
}

+ (void)saveUuid:(NSString *)uuid forKey:(NSString *)key inKeychainItem:(KeychainItemWrapper *)keychainWrapper
{
    [keychainWrapper setObject:uuid forKey:(__bridge id)kSecValueData];
}

+ (NSString *)createUuidKey
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}


@end
