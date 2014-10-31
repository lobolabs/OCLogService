//
//  OCBaseLogger.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDefines.h"

@class OCLogObject;

@interface OCBaseLogger : NSObject

- (NSString *)baseObjectRepresentation:(OCLogObject *)logObject;

@end


@protocol OCBaseLoggerProtocol <NSObject>
@required
- (void)log:(OCLogObject *)logObject;

@end
