//
//  OCLogObjectConsolePrinter.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * OCLogObjectConsolePrinter
 *
 * if OCLogObject implements that protocol
 * than console printer will use these method
 * as object description
 */
@protocol OCLogObjectConsolePrinter <NSObject>

- (NSString *)consolePrint;

@end
