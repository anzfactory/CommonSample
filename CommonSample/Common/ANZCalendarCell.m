//
//  ANZCalendarCell.m
//  CommonSample
//
//  Created by ANZ on 2013/12/13.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "ANZCalendarCell.h"

@interface ANZCalendarCell()

@property (nonatomic) UILabel* lblDay;

@end

@implementation ANZCalendarCell

- (id)init
{
    if (self = [super init]) {
        [self initCell];
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
    }
    
    if ([data.components weekday] == 1) {   // 日曜
        self.backgroundColor = [UIColor redColor];
    } else if ([data.components weekday] == 7) {    // 土曜
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor grayColor] setStroke];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    // 線の幅を指定
    [bezierPath setLineWidth:.5f];
    
    NSArray* vertex = [self drawVertexFromCalendarData];
    // 始点を設定
    [bezierPath moveToPoint:[[vertex firstObject] CGPointValue]];
    // 線を追加
    for (NSUInteger i = 1; i < [vertex count]; i++) {
         [bezierPath addLineToPoint:[vertex[i] CGPointValue]];
    }
    // 線を描画
    [bezierPath stroke];
}

- (NSArray *)drawVertexFromCalendarData
{
    NSArray* vertex;
    if (self.data.isFirstWeek) {            // 第1週か
        
        // 日曜(週の始めか)
        if ([self.data.components weekday] == 1) {
            vertex = @[[NSValue valueWithCGPoint:CGPointMake(0, self.frame.size.height)],
                       [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, self.frame.size.height)]];
        } else {
            vertex = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, self.frame.size.height)]];
        }
        
    } else if (self.data.isLastWeek) {      // 最終週か
        
        // 日曜(週の始めか)
        if ([self.data.components weekday] == 1) {
            vertex = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, self.frame.size.height)],
                       [NSValue valueWithCGPoint:CGPointMake(0, self.frame.size.height)],
                       [NSValue valueWithCGPoint:CGPointMake(0, 0)]];
        } else {
            vertex = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, self.frame.size.height)],
                       [NSValue valueWithCGPoint:CGPointMake(0, self.frame.size.height)]];
        }
        
    } else {
        
        // 日曜(週の始めか)
        if ([self.data.components weekday] == 1) {
            vertex = @[[NSValue valueWithCGPoint:CGPointMake(0, self.frame.size.height)],
                       [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, self.frame.size.height)]];
        } else {
            vertex = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, 0)],
                       [NSValue valueWithCGPoint:CGPointMake(self.frame.size.width, self.frame.size.height)]];
        }
        
    }
    
    return vertex;
}

@end
