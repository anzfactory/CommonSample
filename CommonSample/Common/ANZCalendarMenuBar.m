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

+ (CGSize)size
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30.f);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        // button
        self.btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnClose.frame = CGRectMake(ANZCalendarMenuBarPadding, ANZCalendarMenuBarPadding, 44.f, frame.size.height - (ANZCalendarMenuBarPadding * 2));
//        [self.btnClose setTitle:@"Close" forState:UIControlStateNormal];
//        self.btnClose.titleLabel.font = [UIFont systemFontOfSize:12.f];
        self.btnClose.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.btnClose.backgroundColor = [UIColor clearColor];
        [self.btnClose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnClose addTarget:self action:@selector(callDismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: self.btnClose];
        
        // lbl
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.btnClose.frame.origin.x + self.btnClose.frame.size.width + ANZCalendarMenuBarPadding,
                                                                  ANZCalendarMenuBarPadding,
                                                                  frame.size.width - (self.btnClose.frame.origin.x + self.btnClose.frame.size.width + (ANZCalendarMenuBarPadding * 2)),
                                                                  self.btnClose.frame.size.height)];
        self.lblTitle.textAlignment = NSTextAlignmentRight;
        self.lblTitle.adjustsFontSizeToFitWidth = YES;
        self.lblTitle.backgroundColor = [UIColor clearColor];
        [self addSubview: self.lblTitle];
        
    }
    return self;
}

- (void)setAttributeClose:(NSAttributedString *)attributeClose
{
    _attributeClose = attributeClose;
    [self.btnClose setAttributedTitle:attributeClose forState:UIControlStateNormal];
}

- (void)setAttributeTitle:(NSAttributedString *)attributeTitle
{
    _attributeTitle = attributeTitle;
    self.lblTitle.attributedText = attributeTitle;
}

- (void)callDismiss
{
    if ([self.superview isKindOfClass:[ANZCalendar class]]) {
        [((ANZCalendar *)self.superview) dismiss];
    }
}

@end
