//
//  ANZDropDownField.h
//  CommonSample
//
//  Created by ANZ on 2013/12/04.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANZDropDownField : UITextField <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSArray* dropList;            // 表示するドロップリスト
@property (nonatomic) CGFloat displayNumOfRows;     // 表示件数
@property (nonatomic) CGFloat heightOfListItem;     // リストアイテムの高さ
@property (nonatomic) UIColor* borderColorForList;  // リストの枠線
@property (nonatomic) UIFont* fontOfListItem;       // リストアイテムのフォント

@end
