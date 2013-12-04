//
//  ANZPopupView.m
//  golfdiary
//
//  Created by ANZ on 2013/11/01.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import "ANZPopupView.h"

#import <QuartzCore/QuartzCore.h>

#define ANZPopupViewPadding 10.f

@interface ANZPopupView()
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* message;
@property (nonatomic) UIImage* displayImage;
@property (nonatomic) NSString* positiveTitle;
@property (nonatomic) NSString* negativeTitle;
@end

@implementation ANZPopupView

#pragma mark - lifecycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ANZPopupView" owner: self options: nil];
    self = (ANZPopupView *)[topLevelObjects objectAtIndex: 0];
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initFrame];
    [self initWrapper];
}

#pragma mark - events
- (IBAction)pushPositive:(id)sender {
    
    [self dismiss:^{
        if ([self.delegate respondsToSelector:@selector(didTapPositiveButton)]) {
            [self.delegate didTapPositiveButton];
        }
        [self removeFromSuperview];
    }];
    
}

- (IBAction)pushNegative:(id)sender {
    
    [self dismiss:^{
        if ([self.delegate respondsToSelector:@selector(didTapNegativeButton)]) {
            [self.delegate didTapNegativeButton];
        }
        [self removeFromSuperview];
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.responseType != ANZPopupviewResponseTypeTouchScreen) {
        return;
    }
    
    [self dismiss:^{
        if ([self.delegate respondsToSelector:@selector(didTapNegativeButton)]) {
            [self.delegate didTapNegativeButton];
        }
        [self removeFromSuperview];
    }];
    
}

#pragma mark - method

- (void)initFrame
{
    self.frame = [[UIScreen mainScreen] bounds];
}


- (void)initWrapper
{
    self.thema = ANZPopupViewThemaDefault;
    self.responseType = ANZPopupviewResponseTypeYesNo;
    self.wrapperView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.wrapperView.layer.borderWidth = .5f;
    self.wrapperView.layer.cornerRadius = 5.f;
    
    self.positiveButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.positiveButton.layer.borderWidth = 1.f;
    self.negativeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.negativeButton.layer.borderWidth = 1.f;
}

- (void)showWithTitle:(NSString *)title message:(NSString *)message positiveButtonTitle:(NSString *)positiveTitle negativeButtonTitle:(NSString *)negativeTitle
{
    self.title = title;
    self.message = message;
    self.positiveTitle = positiveTitle;
    self.negativeTitle = negativeTitle;
    
    [self show];
}

- (void)showWithTitle:(NSString *)title image:(UIImage *)image positiveButtonTitle:(NSString *)positiveTitle negativeButtonTitle:(NSString *)negativeTitle
{
    self.title = title;
    self.displayImage = image;
    self.positiveTitle = positiveTitle;
    self.negativeTitle = negativeTitle;
    
    [self show];
}

- (void)showWithCustomView:(UIView *)customView positiveButtonTitle:(NSString *)positiveTitle negativeButtonTitle:(NSString *)negativeTitle
{
    self.positiveTitle = positiveTitle;
    self.negativeTitle = negativeTitle;
    [self.positiveButton setTitle:self.positiveTitle forState:UIControlStateNormal];
    [self.negativeButton setTitle:self.negativeTitle forState:UIControlStateNormal];
    
    // 不要なものを消す
    float titleViewHeight = self.titleView.frame.size.height;       // あとで使う(ちょうせいよう)
    self.titleView.hidden = YES;
    [self.titleView removeFromSuperview];
    
    // 渡されたカスタムビューを追加
    // まずは位置調整
    CGSize customViewSize = customView.frame.size;
    if (customViewSize.width > self.wrapperView.frame.size.width) {
        float rate = self.wrapperView.frame.size.width / customViewSize.width;
        customViewSize = CGSizeMake(customViewSize.width * rate, customViewSize.height * rate);
    }
    
    // wrapper view のサイズ調整
    if (self.responseType == ANZPopupviewResponseTypeTouchScreen) {
        customView.frame = CGRectMake(0,
                                      0,
                                      customViewSize.width,
                                      customViewSize.height);
        self.wrapperView.frame = CGRectMake(0, 0, customViewSize.width, customViewSize.height);
        self.wrapperView.center = self.center;
        self.wrapperView.backgroundColor = [UIColor clearColor];
        self.wrapperView.layer.borderWidth = 0.f;
    } else {
        customView.frame = CGRectMake((self.wrapperView.frame.size.width / 2) - (customViewSize.width / 2),
                                      ANZPopupViewPadding,
                                      customViewSize.width,
                                      customViewSize.height);
        CGRect contentFrame = self.wrapperView.frame;
        contentFrame.size.height += (customView.frame.size.height + ANZPopupViewPadding - titleViewHeight);
        self.wrapperView.frame = contentFrame;
    }
    
    // カスタムビューの背景色を継承しておく
    [self.wrapperView addSubview:customView];
    
    [self setDisplayButtons];
    [self setDisplayThema];
    
    [self popup];
    
}

- (void)show
{
    // まずは固定のものからセット
    if (! [self isEmpty:self.title]) {
        self.titleView.text = self.title;
    }
    if (! [self isEmpty:self.positiveTitle]) {
        [self.positiveButton setTitle:self.positiveTitle forState:UIControlStateNormal];
    }
    if (! [self isEmpty:self.negativeTitle]) {
        [self.negativeButton setTitle:self.negativeTitle forState:UIControlStateNormal];
    }
    
    float extenttionHeight = ANZPopupViewPadding;
    
    if (! [self isEmpty:self.message]) {
        // 本文追加
        self.messageLabel = [UILabel new];
        self.messageLabel.frame = CGRectMake(self.titleView.frame.origin.x, self.titleView.frame.origin.y + self.titleView.frame.size.height + ANZPopupViewPadding, self.titleView.frame.size.width, 0);
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.messageLabel.text = self.message;
        [self.messageLabel sizeToFit];
        
        extenttionHeight += (ANZPopupViewPadding + self.messageLabel.frame.size.height);
        
        [self.wrapperView addSubview:self.messageLabel];
    }
    
    if (self.displayImage) {
        
        if (self.displayImage.size.width > self.titleView.frame.size.width) {
            self.displayImage = [self resizeAdjustWrapperWidth:self.displayImage baseWidth:self.titleView.frame.size.width];
        }
        
        self.displayImageView = [[UIImageView alloc] initWithImage:self.displayImage];
        self.displayImageView.frame = CGRectMake(self.titleView.center.x - (self.displayImage.size.width / 2.f),
                                                 self.titleView.frame.origin.y + self.titleView.frame.size.height + ANZPopupViewPadding,
                                                 self.displayImage.size.width,
                                                 self.displayImage.size.height);
        
        [self.wrapperView addSubview:self.displayImageView];
        
        extenttionHeight += (ANZPopupViewPadding + self.displayImage.size.height);
    }
    
    if (extenttionHeight > 0.f) {
        CGRect contentFrame = self.wrapperView.frame;
        contentFrame.size.height += extenttionHeight;
        self.wrapperView.frame = contentFrame;
    }
    
    [self setDisplayButtons];
    [self setDisplayThema];
    [self popup];
    
}

- (void)popup
{
    self.wrapperView.center = self.center;
    
    // 表示するwindowを見つけ出して表示
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    UIWindow* window = nil;
    for (window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            break;
        }
    }
    
    // 過去に追加したやつがいないかチェク
    for (UIView* child in [window.subviews reverseObjectEnumerator]) {
        if ([child isKindOfClass:[ANZPopupView class]]) {
            [child removeFromSuperview];
        }
    }
    
    // 表示
    [window addSubview:self];

}

- (void)setDisplayButtons
{
    if (self.responseType == ANZPopupviewResponseTypeYesNo) {
    } else if (self.responseType == ANZPopupviewResponseTypeOnlyClose) {
        self.positiveButton.hidden = YES;
        [self.positiveButton removeFromSuperview];
        
        self.negativeButton.center = CGPointMake(self.wrapperView.frame.size.width / 2, self.negativeButton.center.y);
    } else if (self.responseType == ANZPopupviewResponseTypeTouchScreen) {
        self.positiveButton.hidden = YES;
        [self.positiveButton removeFromSuperview];
        self.negativeButton.hidden = YES;
        [self.negativeButton removeFromSuperview];
    }
}

- (void)setDisplayThema
{
    if (self.thema == ANZPopupViewThemaDefault) {
        return;
    }
    
    if (self.thema == ANZPopupViewThemaBlack) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
        self.wrapperView.backgroundColor = [UIColor blackColor];
        self.titleView.textColor = [UIColor whiteColor];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.textColor = [UIColor whiteColor];
        self.positiveButton.backgroundColor = [UIColor whiteColor];
        self.negativeButton.backgroundColor = [UIColor whiteColor];
    } else if (self.thema == ANZPopupViewThemaBrown) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5f];
        self.wrapperView.backgroundColor = [UIColor colorWithRed:106.f / 255.f green:87.f / 255.f blue:60.f / 255.f alpha:1.f];
        self.titleView.textColor = [UIColor whiteColor];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.textColor = [UIColor whiteColor];
        self.positiveButton.backgroundColor = [UIColor colorWithRed:245.f / 255.f green:244.f / 255.f blue:205.f / 255.f alpha:1.f];
        [self.positiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.negativeButton.backgroundColor = [UIColor colorWithRed:245.f / 255.f green:244.f / 255.f blue:205.f / 255.f alpha:1.f];
        [self.negativeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (BOOL)isEmpty:(NSString *)text
{
    return (text == nil || [@"" isEqualToString:text]);
}

- (UIImage *)resizeAdjustWrapperWidth:(UIImage *)target baseWidth:(float)baseWidth
{
    UIImage* result = nil;
    
    float rate = baseWidth / target.size.width;
    CGSize sz = CGSizeMake(target.size.width * rate,
                           target.size.height * rate);
    UIGraphicsBeginImageContext(sz);
    [target drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
    result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

- (void)dismiss:(void (^)())completion
{
    [UIView animateWithDuration:.3f animations:^{
        self.wrapperView.alpha =  0;
        //        self.wrapperView.hidden = YES;
    } completion:^(BOOL finished) {
        completion();
    }];
}

@end
