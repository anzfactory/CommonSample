//
//  ANZCalendar.h
//  CommonSample
//
//  Created by ANZ on 2013/12/12.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANZCalendar;

@protocol ANZCalendarDelegate <UICollectionViewDelegate>

@required

@optional

// 表示後
- (void)showAfterWithCalendar:(ANZCalendar *)calendar;

// 強調する日付かどうか(何か該当するデータがある日なのか？…とか)
- (BOOL)isStrongDayWithDateComponents:(NSDateComponents *)dateComponents;
- (UIView *)accentStrongDayWithDateComponents:(NSDateComponents *)dateComponents cellSize:(CGSize)size;

// 表示年月が変更される直前に呼び出す。呼び出し側で表示年月と合わせてデータ保持を切り替えたい時なんかに
- (void)willRenewCalendarWithNewDate:(NSDate *)newDate;

// カレンダー日付タップ
- (void)didSelectDay:(NSDateComponents *)dateComponents;

// close後
- (void)dismissAfter;

@end
@interface ANZCalendar : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource, ANZCalendarDelegate>

@property (nonatomic, weak) id <ANZCalendarDelegate> delegate;
@property (nonatomic, readonly) NSDate* displayDate;
@property (nonatomic) CGFloat lengthRenew;              // スワイプによるカレンダー切り替えに必要な距離(デフォ：45.f)

// 背景色系
@property (nonatomic) UIColor* colorLine;               // 罫線カラー
@property (nonatomic) UIColor* colorTopBar;             // トップバーの背景色
@property (nonatomic) UIColor* colorNavigatorPrevMonth; // 月変更(前月)の背景色
@property (nonatomic) UIColor* colorNavigatorNextMonth; // 月変更(翌月)の背景色

// 文字系
@property (nonatomic) NSDictionary* attributesWeekday;
@property (nonatomic) NSDictionary* attributesSaturday;
@property (nonatomic) NSDictionary* attributesSunday;
@property (nonatomic) NSDictionary* attributesOutsideWeekday;
@property (nonatomic) NSDictionary* attributesOutsideSaturday;
@property (nonatomic) NSDictionary* attributesOutsideSunday;
@property (nonatomic) NSDictionary* attributesStrongWeekday;
@property (nonatomic) NSDictionary* attributesStrongSaturday;
@property (nonatomic) NSDictionary* attributesStrongSunday;
@property (nonatomic) NSDictionary* attributesClose;
@property (nonatomic) NSDictionary* attributesDisplayDate;
@property (nonatomic) NSDictionary* attributesNavigatorPrev;
@property (nonatomic) NSDictionary* attributesNavigatorNext;

- (id)initWithDisplayDate:(NSDate *)displayDate;
- (void)show;
- (void)dismiss;

@end
