//
//  ANZCalendarNavigator.m
//  CommonSample
//
//  Created by ANZ on 2013/12/20.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "ANZCalendarNavigator.h"

@interface ANZCalendarNavigator()

@property (nonatomic) UILabel* lbl;

@end

@implementation ANZCalendarNavigator

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame navigationType:ANZCalendarNavigatorTypePrevYear];
}

- (id)initWithFrame:(CGRect)frame navigationType:(ANZCalendarNavigatorType)navigationType
{
    if (self = [super initWithFrame:frame]) {
        _navigationType = navigationType;
        
        _lbl = [self createLabel];
        [self addSubview:_lbl];
    }
    return self;
}

- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if ([self isTypeYear]) {
        label.adjustsFontSizeToFitWidth = YES;
    } else {
        label.numberOfLines = 3;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (BOOL)isTypeYear {
    return _navigationType == ANZCalendarNavigatorTypePrevYear || _navigationType == ANZCalendarNavigatorTypeNextYear;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self adjustNavigatorLabel];
    
}

- (void)adjustNavigatorLabel {
    self.lbl.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)updateLabeWithDisplayDate:(NSDate *)displayDate attributes:(NSDictionary *)attributes {
    NSString *displayText = [self displayTextForDate:displayDate];
    self.lbl.attributedText = [[NSAttributedString alloc] initWithString:displayText attributes:attributes];
}

- (NSString *)displayTextForDate:(NSDate *)date {
    NSDateComponents* components = [NSDateComponents new];
    NSTimeZone* tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [components setTimeZone:tz];
    switch (self.navigationType) {
        case ANZCalendarNavigatorTypePrevYear:
            [components setYear: -1];
            break;
            
        case ANZCalendarNavigatorTypeNextYear:
            [components setYear: 1];
            break;
            
        case ANZCalendarNavigatorTypePrevMonth:
            [components setMonth: -1];
            break;
            
        default:
            [components setMonth: 1];
            break;
    }
    
    NSCalendar* calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate* targetDate = [calendar dateByAddingComponents:components toDate:date options:0];
    components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:targetDate];
    
    return [self textForComponents:components];
}

- (NSString *)textForComponents:(NSDateComponents *)components {
    if ([self isTypeYear]) {
        return [NSString stringWithFormat:@"%d", [components year]];
    } else {
        return [self monthStringForInteger:[components month]];
    }
}

- (NSString *)monthStringForInteger:(NSInteger)month {
    switch (month) {
        case 1:
            return @"J\nA\nN";
        case 2:
            return @"F\nE\nB";
        case 3:
            return @"M\nA\nR";
        case 4:
            return @"A\nP\nR";
        case 5:
            return @"M\nA\nY";
        case 6:
            return @"J\nU\nN";
        case 7:
            return @"J\nU\nL";
        case 8:
            return @"A\nU\nG";
        case 9:
            return @"S\nE\nP";
        case 10:
            return @"O\nC\nT";
        case 11:
            return  @"N\nO\nV";
        case 12:
        default:
            return @"D\nE\nC";
    }
}

@end
