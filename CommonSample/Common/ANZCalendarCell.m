//
//  ANZCalendarCell.m
//  CommonSample
//
//  Created by ANZ on 2013/12/13.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "ANZCalendarCell.h"

@interface ANZCalendarCell() {
    UIBezierPath* _bezier;
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
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = .25f;
    
    _lblDay = [UILabel new];
    _lblDay.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lblDay];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.lblDay.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)setData:(ANZCalendarDataObject *)data
{
    _data = data;
    self.lblDay.text = [NSString stringWithFormat:@"%d", [_data.components day]];
    
    if (! data.isCurrentMonth) {    // 穴埋めで表示されてる箇所
        self.lblDay.font = [UIFont systemFontOfSize:10];
        self.lblDay.textColor = [UIColor lightGrayColor];
    } else {
        self.lblDay.font = [UIFont systemFontOfSize:18];
        self.lblDay.textColor = [UIColor blackColor];
    }
    
    if ([data.components weekday] == 1) {   // 日曜
        self.backgroundColor = [UIColor redColor];
    } else if ([data.components weekday] == 7) {    // 土曜
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
