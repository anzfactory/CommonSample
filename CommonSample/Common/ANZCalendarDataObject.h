//
//  ANZCalendarDataObject.h
//  CommonSample
//
//  Created by ANZ on 2013/12/14.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANZCalendarDataObject : NSObject

@property (nonatomic, readonly) NSString* text;
@property (nonatomic) NSDateComponents* components;
@property (nonatomic) BOOL isCurrentMonth;
@property (nonatomic) BOOL isFirstWeek;
@property (nonatomic) BOOL isLastWeek;
@property (nonatomic) BOOL isStrong;
@property (nonatomic) UIView* accentView;

@property (nonatomic) UIColor* colorWeekDay;
@property (nonatomic) UIColor* colorSaturday;
@property (nonatomic) UIColor* colorSunday;
@property (nonatomic) UIColor* colorStrong;

// 文字系
@property (nonatomic) NSDictionary* attributesWeekday;
@property (nonatomic) NSDictionary* attributesSaturday;
@property (nonatomic) NSDictionary* attributesSunday;
@property (nonatomic) NSDictionary* attributesOutsideWeekday;
@property (nonatomic) NSDictionary* attributesOutsideSaturday;
@property (nonatomic) NSDictionary* attributesOutsideSunday;
@property (nonatomic) NSDictionary* attributesStrongWeekday;
@property (nonatomic) NSDictionary* attributesStrongSaturday;
@property (nonatomic) NSDictionary* attributesStrongSunday;


@end
