//
//  OCLogObject.m
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import "OCLogObject.h"
#import "OCLogObject_Protected.h"

#import "NSObject+Autodescription.h"
#import "NSObject+CleanDescription.h"

#import <objc/runtime.h>

@implementation OCLogObject

@synthesize logTime = __logTime;

- (NSString *)logDescriptionForClassType:(Class)classType
{
	NSMutableString * result = [NSMutableString string];
	
	// Find Out something about super Classes
	Class superClass  = class_getSuperclass(classType);
	if  ( superClass != nil && ![superClass isEqual:[OCLogObject class]])
	{
		// Append all the super class's properties to the result (Reqursive, until NSObject)
		[result appendString:[self logDescriptionForClassType:superClass]];
	}
	
	// Add Information about Current Properties
	NSUInteger		  property_count;
	objc_property_t * property_list = class_copyPropertyList(classType, &property_count);
    
	// Reverse order, to get Properties in order they were defined
	for (int i = property_count - 1; i >= 0; --i)
    {
		objc_property_t property = property_list[i];
		
		// For Eeach property we are loading its name
		const char * property_name = property_getName(property);
		
		NSString * propertyName = [NSString stringWithCString:property_name encoding:NSASCIIStringEncoding];
		if (propertyName)
        {
			id value = [self valueForKey:propertyName];
            NSString *print;
            if ([value isKindOfClass:[[self class] nestedClass]]) {
                if ([value conformsToProtocol:@protocol(OCLogObjectProtocol)])
                    print = [NSString stringWithFormat:@"\n%@\n", [value objectDescription]];
                else
                    print = [NSString stringWithFormat:@"\n%@\n", [value autoDescription]];
            }
            else
                print = [value cleanDescription];
            
			// format of result items: p1 = v1; p2 = v2; ...
			[result appendFormat:@"%@ = %@; ", propertyName, print];
		}
	}
	free(property_list);
	
	return result;
}

#pragma mark - log auto description

- (NSString *)logDescription
{
    return [NSString stringWithFormat:@"%@ [%@ {%@}]",
            [[[self class] dateFormatter] stringFromDate:__logTime],
            NSStringFromClass([self class]),
            [self logDescriptionForClassType:[self class]]];
}

+ (BOOL) AMCEnabled
{
    return TRUE;
}

#pragma mark - Private class methods

+ (Class)nestedClass
{
    return nil;
}

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    });
    return dateFormatter;
}

#pragma mark - JSONModel setup

+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
