//
//  NSString+Extention.h
//
//  Created by ANZ on 2013/11/19.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extention)

+ (NSString *)convertFromInt:(NSInteger)val;
+ (NSString *)convertFromFloat:(float)val;

+ (BOOL)isEmptyWithString:(NSString *)string;

- (NSString *)camelCase;
- (NSString *)camelCaseWithSeparator:(NSString *)separtor;

@end
