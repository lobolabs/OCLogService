//
//  NSObject+AutoDescription.m
//  NSObject-AutoDescription
//
//  Created by Alexey Aleshkov on 09.05.13.
//  Copyright (c) 2013 Alexey Aleshkov. All rights reserved.
//
//  Email:  mailto:djmadcat@gmail.com
//  Github: https://github.com/djmadcat
//


#import "NSObject+AutoDescription.h"
#import <objc/runtime.h>
#import "NSObject+CleanDescription.h"

#import "OCLodableCategory.h"

MAKE_CATEGORIES_LOADABLE(NSObject_AutoDescription)

@implementation NSObject (AutoDescription)

- (NSString *)autoDescription
{
	return [NSString stringWithFormat:@"<%@: %p; %@>", NSStringFromClass([self class]), self, [self keyValueAutoDescription]];
}

- (NSString *)keyValueAutoDescription
{
	NSMutableString *result = [NSMutableString string];

	Class currentClass = [self class];
	while (currentClass != [NSObject class]) {
		unsigned int propertyListCount = 0;
		objc_property_t *propertyList = class_copyPropertyList(currentClass, &propertyListCount);
		for (int i = 0; i < propertyListCount; i++) {
			const char *property_name = property_getName(propertyList[i]);
			NSString *propertyName = [NSString stringWithCString:property_name encoding:NSASCIIStringEncoding];

			if (propertyName) {
				id propertyValue = [self valueForKey:propertyName];
				[result appendFormat:@"%@ = %@; ", propertyName, [propertyValue cleanDescription]];
			}
		}
		free(propertyList);
		currentClass = class_getSuperclass(currentClass);
	}
	NSUInteger length = [result length];
	if (length) {
		[result deleteCharactersInRange:NSMakeRange(length - 1, 1)];
	}

	return result;
}

@end
