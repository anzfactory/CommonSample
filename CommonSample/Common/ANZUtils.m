//
//  ANZUtils.m
//
//  Created by ANZ on 2013/11/01.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import "ANZUtils.h"

@implementation ANZUtils

+ (float)currentSysytemVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (BOOL)isLaterOS7
{
    float currentVersion = [ANZUtils currentSysytemVersion];
    return currentVersion >= 7.f;
}

+ (float)heightMainScreen
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (NSString *)curretnDateFormatYMD
{
    return [ANZUtils dateFormatYMD:[NSDate date]];
}

+ (NSString *)dateFormatYMD:(NSDate *)date
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                               fromDate:date];
    
    return [NSString stringWithFormat:@"%d/%d/%d", [components year], [components month], [components day]];

}

+ (NSUInteger)lengthOfMonthWithCalendar:(NSCalendar *)calendar targetDate:(NSDate *)date
{
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    return range.length;
}

@end
