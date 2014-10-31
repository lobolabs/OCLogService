//
//  OCLogObjectFilePrinter.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * OCLogObjectFilePrinter
 *
 * if OCLogObject implements that protocol
 * than file printer will use these method
 * as object description
 */
@protocol OCLogObjectFilePrinter <NSObject>

- (NSString *)filePrint;

@end
