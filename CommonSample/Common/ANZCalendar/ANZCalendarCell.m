//
//  ANZCalendarCell.m
//  CommonSample
//
//  Created by ANZ on 2013/12/13.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "ANZCalendarCell.h"

typedef enum {
    AnzCalendarCellTagAccent = 100
} ANZCalendarCellTag;

@interface ANZCalendarCell() {
    UIBezierPath* _bezier;
    UIView *_accent;
}

@property (nonatomic) UILabel* lblDay;

@end

@implementation ANZCalendarCell

- (id)init
{
    if (self = [self initWithFrame:CGRectZero]) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self initCell];
    }
    return self;
}

- (void)initCell
{
    self.layer.borderWidth = .25f;
    
    _lblDay = [UILabel new];
    _lblDay.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lblDay];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.layer.borderColor = self.lineColor.CGColor;
}

- (void)setData:(ANZCalendarDataObject *)data
{
    _data = data;
    [self resetAssent:_data];
    
    NSString* dayString = [NSString stringWithFormat:@"%ld", [_data.components day]];
    NSDictionary* dayAttributes;
    
    if ([data.components weekday] == 1) {   // 日曜
        if (data.isStrong) {
            dayAttributes = data.attributesStrongSunday;
        } else if (data.isCurrentMonth) {
            dayAttributes = data.attributesSunday;
        } else {
            dayAttributes = data.attributesOutsideSunday;
        }
    } else if ([data.components weekday] == 7) {    // 土曜
        if (data.isStrong) {
            dayAttributes = data.attributesStrongSaturday;
        } else if (data.isCurrentMonth) {
            dayAttributes = data.attributesSaturday;
        } else {
            dayAttributes = data.attributesOutsideSaturday;
        }
    } else {
        if (data.isStrong) {
            dayAttributes = data.attributesStrongSunday;
        } else if (data.isCurrentMonth) {
            dayAttributes = data.attributesWeekday;
        } else {
            dayAttributes = data.attributesOutsideWeekday;
        }
    }
    self.lblDay.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.lblDay.backgroundColor = dayAttributes[NSBackgroundColorAttributeName];
    self.lblDay.attributedText = [[NSAttributedString alloc] initWithString:dayString attributes:dayAttributes];
}

- (void)resetAssent:(ANZCalendarDataObject *)data {
    if (_accent) {
        [_accent removeFromSuperview];
    }
    
    if (data.accentView) {
        _accent = data.accentView;
        _accent.tag = AnzCalendarCellTagAccent;
        [self addSubview:_accent];
    }
}

@end
