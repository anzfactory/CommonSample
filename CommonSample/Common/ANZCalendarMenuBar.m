//
//  ANZCalendarMenuBar.m
//  CommonSample
//
//  Created by ANZ on 2013/12/17.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "ANZCalendarMenuBar.h"

#import "ANZCalendar.h"

#define ANZCalendarMenuBarPadding 5.f

@interface ANZCalendarMenuBar()

@property (nonatomic) UIButton* btnClose;
@property (nonatomic) UILabel* lblTitle;

@end

@implementation ANZCalendarMenuBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        // button
        self.btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnClose.frame = CGRectMake(ANZCalendarMenuBarPadding, ANZCalendarMenuBarPadding, 44.f, frame.size.height - (ANZCalendarMenuBarPadding * 2));
        [self.btnClose setTitle:@"Close" forState:UIControlStateNormal];
        self.btnClose.titleLabel.font = [UIFont systemFontOfSize:12.f];
        self.btnClose.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.btnClose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnClose addTarget:self action:@selector(callDismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: self.btnClose];
        
        // lbl
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.btnClose.frame.origin.x + self.btnClose.frame.size.width + ANZCalendarMenuBarPadding,
                                                                  ANZCalendarMenuBarPadding,
                                                                  frame.size.width - (self.btnClose.frame.origin.x + self.btnClose.frame.size.width + (ANZCalendarMenuBarPadding * 2)),
                                                                  self.btnClose.frame.size.height)];
        self.lblTitle.textColor = [UIColor whiteColor];
        self.lblTitle.textAlignment = NSTextAlignmentRight;
        self.lblTitle.font = [UIFont systemFontOfSize:14.f];
        self.lblTitle.adjustsFontSizeToFitWidth = YES;
        [self addSubview: self.lblTitle];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.lblTitle.text = title;
}


- (void)callDismiss
{
    if ([self.superview isKindOfClass:[ANZCalendar class]]) {
        [((ANZCalendar *)self.superview) dismiss];
    }
}

@end
