//
//  NSString+Extention.m
//  golfdiary
//
//  Created by ANZ on 2013/11/19.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

+ (NSString *)convertFromInt:(NSInteger)val
{
    return [NSString stringWithFormat:@"%ld", (long)val];
}

+ (NSString *)convertFromFloat:(float)val
{
    return [NSString stringWithFormat:@"%f", val];
}

+ (BOOL)isEmptyWithString:(NSString *)string
{
    return (string == nil || [@"" isEqualToString:string] );
}

- (NSString *)camelCase
{
    return [self camelCaseWithSeparator:nil];
}
- (NSString *)camelCaseWithSeparator:(NSString *)separtor
{
    NSString* result = self;
    if (separtor == nil) {
        result = [self capitalizedString];
        if (! [NSString isEmptyWithString:result]) {
            result = [[[result substringToIndex:1] lowercaseString] stringByAppendingString:[result substringFromIndex:([result length] - 1)]];
        }
    } else {
        if (! [NSString isEmptyWithString:result]) {
            NSArray* arr = [result componentsSeparatedByString:separtor];
            NSString* item;
            NSInteger index = ([arr count] - 1);
            result = @"";
            for (item in [arr reverseObjectEnumerator]) {
                if ( index == 0 ) {
                    result = [[item lowercaseString] stringByAppendingString: result];
                } else {
                    result = [[[[item substringToIndex:1] uppercaseString] stringByAppendingString:[[item substringFromIndex:(1)] lowercaseString]] stringByAppendingString: result];
                }
                index--;
            }
            
        }
    }
    return result;
}

@end
