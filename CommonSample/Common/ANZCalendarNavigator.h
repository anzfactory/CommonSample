//
//  ANZCalendarNavigator.h
//  CommonSample
//
//  Created by ANZ on 2013/12/20.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ANZCalendarNavigatorTypePrevYear,
    ANZCalendarNavigatorTypeNextYear,
    ANZCalendarNavigatorTypePrevMonth,
    ANZCalendarNavigatorTypeNextMonth
} ANZCalendarNavigatorType;

@interface ANZCalendarNavigator : UIView

@property (nonatomic, readonly) ANZCalendarNavigatorType navigationType;

- (id)initWithFrame:(CGRect)frame navigationType:(ANZCalendarNavigatorType)navigationType;
- (void)updateLabeWithDisplayDate:(NSDate *)displayDate attributes:(NSDictionary*)attributes;
@end
