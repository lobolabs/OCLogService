//
//  OCServiceLogger.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/23/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCBaseLogger.h"

@interface OCServiceLogger : OCBaseLogger <OCBaseLoggerProtocol>

- (instancetype)initWithUUID:(NSString *)uuid andBatchClass:(Class)batchClass url:(NSURL *)url;
- (instancetype)init ATTR_UNAVAILABLE_MSG("use: initWithUUID:andBatchClass:url: instead");

- (void)setFlushInterval:(NSTimeInterval)flushInterval;

- (void)flushLogs;

@end
