//
//  ANZDropDownField.m
//  CommonSample
//
//  Created by ANZ on 2013/12/04.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "ANZDropDownField.h"

#import <QuartzCore/QuartzCore.h>

@interface ANZDropDownField() {
    CGFloat _borderWidth;
}

@property (nonatomic) UITableView* tableView;

@end

@implementation ANZDropDownField

static NSString* _cellID = @"cell";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self prepare];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self prepare];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dropList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:_cellID];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellID];
        cell.contentView.backgroundColor = self.backgroundColor;
        cell.textLabel.textAlignment = self.textAlignment;
        cell.textLabel.font = self.font;
        cell.textLabel.textColor = self.textColor;
    }
    
    if (self.fontOfListItem) {
        cell.textLabel.font = self.fontOfListItem;
    }
    
    cell.textLabel.text = self.dropList[indexPath.item];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.heightOfListItem;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideDropDownListWithUpdateText:self.dropList[indexPath.item]];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (! self.dropList || [self.dropList count] == 0) {
        return YES;
    }
    
    if (self.tableView.superview) {
        [self hideDropDownList];
    } else {
        [self showDropDownList];
    }
    
    return NO;
}

#pragma mark - methods
- (void)prepare
{
    _borderWidth = .5f;
    
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.borderWidth = _borderWidth;
    
    _displayNumOfRows = 5;
    _heightOfListItem = self.frame.size.height;
    _borderColorForList = [UIColor lightGrayColor];

}

- (void)showDropDownList
{
    [self adjustTableView];     // 表示するドロップリストの高さ調整
    
    self.tableView.hidden = YES;
    
    [self.superview addSubview:self.tableView];
    [self.superview bringSubviewToFront:self];
    
    CGAffineTransform affine = CGAffineTransformMakeScale(1, 0);
    self.tableView.transform = affine;
    
    self.tableView.hidden = NO;
    [UIView animateWithDuration:.2f animations:^{
        self.tableView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideDropDownList
{
    [self hideDropDownListWithUpdateText:self.text];
}

- (void)hideDropDownListWithUpdateText:(NSString *)updateText;
{
    CGAffineTransform affine = CGAffineTransformScale(self.tableView.transform, 1, 0);

    [UIView animateWithDuration:.2f animations:^{
        self.tableView.transform = affine;
    } completion:^(BOOL finished) {
        self.text = updateText;
        self.tableView.hidden = YES;
        self.tableView.transform = CGAffineTransformIdentity;
        [self.tableView removeFromSuperview];
    }];
}

- (void)adjustTableView
{
    NSUInteger numOfRows = 0;
    if (self.displayNumOfRows > [self.dropList count]) {
        numOfRows = [self.dropList count];
    } else {
        numOfRows = self.displayNumOfRows;
    }
    
    CGFloat heightTableVeiw = self.heightOfListItem * numOfRows;
    CGPoint startPoint = CGPointZero;
    CGFloat selfBottomLine = self.frame.origin.y + self.frame.size.height;
    
    // 下にドロップ表示できるか判定 (マージン30.f)
    if ((self.superview.frame.size.height - (selfBottomLine + 30.f)) > heightTableVeiw) {
        self.tableView.layer.anchorPoint = CGPointMake(.5f, 0);
        startPoint = CGPointMake(self.frame.origin.x, selfBottomLine - 1.f);
    } else {
        self.tableView.layer.anchorPoint = CGPointMake(.5f, 1);
        startPoint = CGPointMake(self.frame.origin.x, (self.frame.origin.y - heightTableVeiw) + 1.f);
    }
    
    self.tableView.layer.cornerRadius = self.layer.cornerRadius;
    self.tableView.frame = CGRectMake(startPoint.x,
                                      startPoint.y,
                                      self.frame.size.width,
                                      heightTableVeiw);
    
    self.tableView.layer.borderColor = self.borderColorForList.CGColor;
    self.tableView.backgroundColor = self.backgroundColor;
    
}

@end
