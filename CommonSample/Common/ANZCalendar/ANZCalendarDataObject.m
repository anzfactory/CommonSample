//
//  ANZCalendarDataObject.m
//  CommonSample
//
//  Created by ANZ on 2013/12/14.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "ANZCalendarDataObject.h"

@implementation ANZCalendarDataObject

- (NSString *)text
{
    if (! self.components) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%ld", [self.components day]];
}

- (NSDictionary *)attributes {
    if ([_components weekday] == 1) {   // 日曜
        if (_isStrong) {
            return _attributesStrongSunday;
        } else if (_isCurrentMonth) {
            return _attributesSunday;
        } else {
            return _attributesOutsideSunday;
        }
    } else if ([_components weekday] == 7) {    // 土曜
        if (_isStrong) {
            return _attributesStrongSaturday;
        } else if (_isCurrentMonth) {
            return _attributesSaturday;
        } else {
            return _attributesOutsideSaturday;
        }
    } else {
        if (_isStrong) {
            return _attributesStrongWeekday;
        } else if (_isCurrentMonth) {
            return _attributesWeekday;
        } else {
            return _attributesOutsideWeekday;
        }
    }
}
@end
