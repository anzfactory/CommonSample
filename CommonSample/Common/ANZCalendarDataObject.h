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

@end
