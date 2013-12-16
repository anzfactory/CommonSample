//
//  ANZUtils.h
//
//  Created by ANZ on 2013/11/01.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANZUtils : NSObject

+ (float)currentSysytemVersion;
+ (float)heightMainScreen;

+ (NSString *)curretnDateFormatYMD;
+ (NSString *)dateFormatYMD:(NSDate *)date;
+ (NSUInteger)lengthOfMonthWithCalendar:(NSCalendar *)calendar targetDate:(NSDate *)date;

@end
