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

@end
