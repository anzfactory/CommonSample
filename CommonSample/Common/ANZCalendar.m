//
//  ANZCalendar.m
//  CommonSample
//
//  Created by ANZ on 2013/12/12.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "ANZCalendar.h"

#import <QuartzCore/QuartzCore.h>
#import "ANZCalendarCell.h"
#import "ANZCalendarDataObject.h"
#import "ANZCalendarMenuBar.h"
#import "ANZCalendarNavigator.h"

#define ANZCalendarNumDays 7

typedef enum {
    ANZCalendarRenewNone,
    ANZCalendarRenewPrev,
    ANZCalendarRenewNext
} ANZCalendarRenew;

@interface ANZCalendar() {
    NSCalendar* _calendar;
    UIWindow* _parentWindow;
    ANZCalendarRenew _renewType;
}

@property (nonatomic, weak, readonly) id<ANZCalendarDelegate> anzDelegate;
@property (nonatomic) NSArray* ds;
@property (nonatomic) ANZCalendarNavigator* prevBackgroundView;
@property (nonatomic) ANZCalendarNavigator* nextBackgroundView;

@end

@implementation ANZCalendar

static NSString* _cellID = @"cellID";
static NSString* _sectionID = @"sectionID";

+ (UICollectionViewFlowLayout *)flowLayout
{
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.headerReferenceSize = [ANZCalendarMenuBar size];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    CGFloat itemWidth = floorf(layout.headerReferenceSize.width / ANZCalendarNumDays);
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    CGFloat padding = (layout.headerReferenceSize.width - (itemWidth * ANZCalendarNumDays)) / 2;
    layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    return layout;
}

- (void)reloadData
{
    [super reloadData];
    
    // viewControllerのautomaticallyAdjustsScrollViewInsetsに対抗
    self.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.contentInset = UIEdgeInsetsZero;

}

- (void)create
{
    _calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    _renewType = ANZCalendarRenewNone;
    _colorLine = [UIColor lightGrayColor];
    _colorTopBar = [UIColor grayColor];
    _colorNavigatorPrevMonth = [UIColor lightGrayColor];
    _colorNavigatorNextMonth = [UIColor lightGrayColor];
    _lengthRenew = 45.f;
    
    _attributesWeekday = @{NSForegroundColorAttributeName : [UIColor darkGrayColor],
                           NSBackgroundColorAttributeName : [UIColor whiteColor],
                           NSFontAttributeName            : [UIFont boldSystemFontOfSize:16]};
    _attributesSaturday = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                            NSBackgroundColorAttributeName : [UIColor blueColor],
                            NSFontAttributeName            : [UIFont boldSystemFontOfSize:16]};
    _attributesSunday = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                          NSBackgroundColorAttributeName : [UIColor redColor],
                          NSFontAttributeName            : [UIFont boldSystemFontOfSize:16]};
    _attributesOutsideWeekday = @{NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                  NSBackgroundColorAttributeName : [UIColor whiteColor],
                                  NSFontAttributeName            : [UIFont systemFontOfSize:14]};
    _attributesOutsideSaturday = @{NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                   NSBackgroundColorAttributeName : [UIColor blueColor],
                                   NSFontAttributeName            : [UIFont systemFontOfSize:14]};
    _attributesOutsideSunday = @{NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                 NSBackgroundColorAttributeName : [UIColor redColor],
                                NSFontAttributeName             : [UIFont systemFontOfSize:14]};
    _attributesStrongWeekday = @{NSForegroundColorAttributeName : [UIColor yellowColor],
                                 NSBackgroundColorAttributeName : [UIColor orangeColor],
                                 NSFontAttributeName            : [UIFont boldSystemFontOfSize:18]};
    _attributesStrongSaturday = @{NSForegroundColorAttributeName : [UIColor yellowColor],
                                  NSBackgroundColorAttributeName : [UIColor orangeColor],
                                  NSFontAttributeName            : [UIFont boldSystemFontOfSize:18]};
    _attributesStrongSunday = @{NSForegroundColorAttributeName   : [UIColor yellowColor],
                                  NSBackgroundColorAttributeName : [UIColor orangeColor],
                                  NSFontAttributeName            : [UIFont boldSystemFontOfSize:18]};
    _attributesClose = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                         NSFontAttributeName            : [UIFont systemFontOfSize:14]};
    _attributesDisplayDate = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                               NSFontAttributeName            : [UIFont boldSystemFontOfSize:16]};
    _attributesNavigatorPrev = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName            : [UIFont boldSystemFontOfSize:14]};
    _attributesNavigatorNext = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName            : [UIFont boldSystemFontOfSize:14]};
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
    
    self.ds = [NSMutableArray new];
    self.delegate = self;
    self.dataSource = self;
    self.alwaysBounceHorizontal = YES;
    [self registerClass:[ANZCalendarCell class] forCellWithReuseIdentifier:_cellID];
    [self registerClass:[ANZCalendarMenuBar class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:_sectionID];
    
    self.prevBackgroundView = [[ANZCalendarNavigator alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height) navigationType:ANZCalendarNavigatorTypePrevMonth];
    [self.prevBackgroundView updateLabeWithDisplayDate:self.displayDate attributes:self.attributesNavigatorPrev];
    
    self.nextBackgroundView = [[ANZCalendarNavigator alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, 0, self.frame.size.height) navigationType:ANZCalendarNavigatorTypeNextMonth];
    [self.nextBackgroundView updateLabeWithDisplayDate:self.displayDate attributes:self.attributesNavigatorNext];
    
    [self addSubview:self.prevBackgroundView];
    [self addSubview:self.nextBackgroundView];
    
}

- (NSMutableArray *)createCalendarFromDisplayDate:(NSDate *)displayDate
{
    NSMutableArray* result = [NSMutableArray new];
    NSTimeZone* tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSRange range = [_calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:displayDate];
    NSUInteger numOfMonth = range.length;
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSWeekCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSQuarterCalendarUnit | NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit | NSYearForWeekOfYearCalendarUnit;
    
    NSDateComponents* originComponents = [_calendar components:flags fromDate:displayDate];
    [originComponents setTimeZone:tz];
    [originComponents setDay:numOfMonth];
    NSDate* finalDay = [_calendar dateFromComponents:originComponents];
    NSDateComponents* finalDayComponents = [_calendar components:flags fromDate:finalDay];
    
    ANZCalendarDataObject* dataObj;
    NSDateComponents* components = [NSDateComponents new];
    [components setTimeZone:tz];
    [components setYear: [originComponents year]];
    [components setMonth: [originComponents month]];
    [components setDay:1];
    int secondsDay = 60 * 60 * 24;
    NSDate* firstDate = [_calendar dateFromComponents:components];
    for (int i = 0; i < numOfMonth; i++) {
        dataObj = [ANZCalendarDataObject new];
        dataObj.components = [_calendar components: flags fromDate: [firstDate dateByAddingTimeInterval:secondsDay * i]];
        dataObj.isCurrentMonth = YES;
        dataObj.isFirstWeek = [dataObj.components weekOfMonth] == 1;
        dataObj.isLastWeek = [finalDayComponents weekOfMonth] == [dataObj.components weekOfMonth];
        [result addObject: dataObj];
    }
    
    components = [_calendar components:flags fromDate:firstDate];
    [components setTimeZone: tz];
    
    // 第1週目の穴埋め
    NSInteger weekDay = [components weekday];
    if (weekDay != 1) {     // 週初め(日曜じゃなかったら)
        // 月初日から一日前で先月月末日
        for (int i = 1; i < weekDay; i++) {
            dataObj = [ANZCalendarDataObject new];
            dataObj.components = [_calendar components:flags fromDate:[firstDate dateByAddingTimeInterval:(secondsDay * -1 * i)]];
            dataObj.isCurrentMonth = NO;
            dataObj.isFirstWeek = YES;
            dataObj.isLastWeek = NO;
            [result insertObject:dataObj atIndex:0];
        }
    }
    
    // 最終週の穴埋め
    NSUInteger numBlank = [result count] % ANZCalendarNumDays;
    if (numBlank > 0) {
        // 元々の月の最終日に1日プラスで翌月初日
        NSDate* nextMonth = [finalDay dateByAddingTimeInterval:secondsDay];
        for (int i = 0; i < (ANZCalendarNumDays - numBlank); i++) {
            dataObj = [ANZCalendarDataObject new];
            dataObj.components = [_calendar components:flags fromDate:[nextMonth dateByAddingTimeInterval:secondsDay * i]];
            dataObj.isCurrentMonth = NO;
            dataObj.isFirstWeek = NO;
            dataObj.isLastWeek = YES;
            [result addObject: dataObj];
        }
    }
    
    return result;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.ds count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ANZCalendarCell* cell = [self dequeueReusableCellWithReuseIdentifier:_cellID forIndexPath:indexPath];
    ANZCalendarDataObject* dataObj = ((ANZCalendarDataObject *)self.ds[indexPath.item]);
    
    if ([_anzDelegate respondsToSelector:@selector(isStrongDayWithDateComponents:)]) {
        dataObj.isStrong = [_anzDelegate isStrongDayWithDateComponents:dataObj.components];
    } else {
        dataObj.isStrong = NO;
    }
    
    dataObj.attributesWeekday = self.attributesWeekday;
    dataObj.attributesSaturday = self.attributesSaturday;
    dataObj.attributesSunday = self.attributesSunday;
    dataObj.attributesOutsideWeekday = self.attributesOutsideWeekday;
    dataObj.attributesOutsideSaturday = self.attributesOutsideSaturday;
    dataObj.attributesOutsideSunday = self.attributesOutsideSunday;
    dataObj.attributesStrongWeekday = self.attributesStrongWeekday;
    dataObj.attributesStrongSaturday = self.attributesStrongSaturday;
    dataObj.attributesStrongSunday = self.attributesStrongSunday;
    
    cell.data = dataObj;
    cell.lineColor = self.colorLine;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // この一文がないと、月に表示する日数が変わる(行数が減る)場合に落ちる
    [self.collectionViewLayout invalidateLayout];
    return 1;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ANZCalendarMenuBar* section = (ANZCalendarMenuBar *)[self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:_sectionID forIndexPath:indexPath];
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy/MM"];
        section.attributeClose = [[NSAttributedString alloc] initWithString:@"Close" attributes:self.attributesClose];
        section.attributeTitle = [[NSAttributedString alloc] initWithString:[formatter stringFromDate:self.displayDate ] attributes:self.attributesDisplayDate];
        section.backgroundColor = self.colorTopBar;
        return section;
    } else {
        return nil;
    }
}

- (id)initWithDisplayDate:(NSDate *)displayDate
{
    // contentViewを正しく計算させるためにとりあえず幅だけは指定しておく
    if (self == [super initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 0) collectionViewLayout:[ANZCalendar flowLayout]]) {
        _displayDate = displayDate;
        [self create];
    }
    return self;
}

- (void)show
{
    // 表示するカレンダーデータの作成
    self.ds = [self createCalendarFromDisplayDate:self.displayDate];
    
    // 表示するwindowを見つけ出して表示
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow* window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            _parentWindow = window;
            break;
        }
    }
    
    // 過去に追加したやつがいないかチェク
    BOOL through = NO;
    for (UIView* child in [_parentWindow.subviews reverseObjectEnumerator]) {
        
        // 自分自身がすでに表示されている場合はスルーさせる
        if ([child isEqual:self]) {
            through = YES;
            continue;
        }
        
        // 自分自身以外でどうクラスのインスタンスがあれば消す
        if ([child isKindOfClass:[self class]]) {
            [child removeFromSuperview];
        }
    }
    
    if (through) {
        return;
    }
    
    // サイズ・表示位置調整
    // collectionViewContentSizeでcontentsizeが取れるのでそこらへんを考慮して自動的にピッタリのサイズにする
    CGSize contentSize = [self.collectionViewLayout collectionViewContentSize];
    self.frame = CGRectMake(self.frame.origin.x, _parentWindow.frame.size.height, self.frame.size.width, contentSize.height);
    
    // 表示
    [_parentWindow addSubview:self];
    
    [UIView animateWithDuration:.5f animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height * -1);
    } completion:^(BOOL finished) {
        if ([self.anzDelegate respondsToSelector:@selector(showAfterWithCalendar:)]) {
            [self.anzDelegate showAfterWithCalendar:self];
        }
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:.5f animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, _parentWindow.frame.size.height, self.frame.size.width, self.frame.size.height);
        self.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
        
        if ([self.anzDelegate respondsToSelector:@selector(dismissAfter)]) {
            [self.anzDelegate dismissAfter];
        }
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.prevBackgroundView.frame = CGRectMake(self.prevBackgroundView.frame.origin.x, self.prevBackgroundView.frame.origin.y, self.prevBackgroundView.frame.size.width, self.frame.size.height);
    self.prevBackgroundView.backgroundColor = self.colorNavigatorPrevMonth;
    self.nextBackgroundView.frame = CGRectMake(self.nextBackgroundView.frame.origin.x, self.nextBackgroundView.frame.origin.y, self.nextBackgroundView.frame.size.width, self.frame.size.height);
    self.nextBackgroundView.backgroundColor = self.colorNavigatorNextMonth;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (scrollView.contentOffset.x > 0) {
        self.nextBackgroundView.frame = CGRectMake(self.nextBackgroundView.frame.origin.x,
                                                   self.nextBackgroundView.frame.origin.y,
                                                   offset.x,
                                                   self.nextBackgroundView.frame.size.height);
    } else if (scrollView.contentOffset.x < 0) {
        self.prevBackgroundView.frame = CGRectMake(offset.x,
                                                   self.prevBackgroundView.frame.origin.y,
                                                   offset.x * -1,
                                                   self.prevBackgroundView.frame.size.height);
    } else {
        
    }
}

//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    NSLog(@"scrollViewWillEndDragging");
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"scrollViewDidEndDragging");
//}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
{
    if (fabsf(scrollView.contentOffset.x) > self.lengthRenew) {
        if (scrollView.contentOffset.x > 0) {
            _renewType = ANZCalendarRenewNext;
        } else {
            _renewType = ANZCalendarRenewPrev;
        }
    } else {
        _renewType = ANZCalendarRenewNone;
        return;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    
    if (scrollView.contentOffset.x == 0) {
        [self renewCalendar];
    }
}

- (void)renewCalendar
{
    if (_renewType == ANZCalendarRenewNone) {
        return;
    }
    
    NSDateComponents* components = [NSDateComponents new];
    [components setMonth:(_renewType == ANZCalendarRenewNext ? 1 : -1)];
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    _displayDate = [_calendar dateByAddingComponents:components toDate:self.displayDate options:0];
    self.ds = [self createCalendarFromDisplayDate:self.displayDate];
    
    if ([self.anzDelegate respondsToSelector:@selector(willRenewCalendarWithNewDate:)]) {
        [self.anzDelegate willRenewCalendarWithNewDate:self.displayDate];
    }

    [self reloadSections:[NSIndexSet indexSetWithIndex:0]];

}

- (void)reloadSections:(NSIndexSet *)sections
{
    [super reloadSections:sections];
    
    CGSize contentSize = [self.collectionViewLayout collectionViewContentSize];
    CGFloat diff = self.frame.size.height - contentSize.height;
    
    [UIView animateWithDuration:.1f animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + diff,self.frame.size.width,contentSize.height);
    } completion:^(BOOL finished) {
        [self.prevBackgroundView updateLabeWithDisplayDate:self.displayDate attributes:self.attributesNavigatorPrev];
        [self.nextBackgroundView updateLabeWithDisplayDate:self.displayDate attributes:self.attributesNavigatorNext];
    }];
}

- (void)setDelegate:(id<UICollectionViewDelegate, ANZCalendarDelegate>)delegate
{
    if (self == delegate) {
        [super setDelegate:delegate];    // こっちは内部用
    } else {
        _anzDelegate = delegate;         // こっちは呼び出し側用
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (! [self.anzDelegate respondsToSelector:@selector(didSelectDay:)]) {
        return;
    }
    
    ANZCalendarDataObject* dataObj = (ANZCalendarDataObject *)self.ds[indexPath.item];
    [self.anzDelegate didSelectDay:dataObj.components];
    
    [self dismiss];
}

@end
