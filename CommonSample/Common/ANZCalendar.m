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

#define ANZCalendarHeight 320.f
#define ANZCalendarWidth 320.f
#define ANZCalendarNumDays 7

@interface ANZCalendar() {
    NSCalendar* _calendar;
}

@property (nonatomic) UIToolbar* headerBar;
@property (nonatomic) UIBarButtonItem* btnClose;
@property (nonatomic) UIBarButtonItem* btnChangeDisplayFormat;
@property (nonatomic) UILabel* lblTitle;
@property (nonatomic) UICollectionView* calendarView;
@property (nonatomic) NSMutableArray* ds;

@end

@implementation ANZCalendar

static NSString* _cellID = @"cellID";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self create];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setYear:2013];
    [components setMonth:12];
    [components setDay:24];
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [self createCalendarFromDisplayDate:[_calendar dateFromComponents:components]];
    self.lblTitle.text = [NSString stringWithFormat:@"%d/%d", [components year], [components month]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)create
{
    _calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    self.ds = [NSMutableArray new];
    
    // toolbar
    self.headerBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ANZCalendarWidth, 44.f)];
    self.btnClose = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    self.btnChangeDisplayFormat = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                target:self
                                                                                action:@selector(changeDisplayFormat)];
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 30)];
    self.lblTitle.adjustsFontSizeToFitWidth = YES;
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    
    UIBarButtonItem* btnTitle = [[UIBarButtonItem alloc] initWithCustomView:self.lblTitle];

    UIBarButtonItem* flexibleSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    
    self.headerBar.items = @[self.btnClose,
                             flexibleSpacer,
                             btnTitle,
                             flexibleSpacer,
                             self.btnChangeDisplayFormat];
    
    [self addSubview:self.headerBar];
    
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(45, 45);
    layout.sectionInset = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
    self.calendarView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.headerBar.frame.origin.y + self.headerBar.frame.size.height, ANZCalendarWidth, 250) collectionViewLayout:layout];
    self.calendarView.delegate = self;
    self.calendarView.dataSource = self;
    [self.calendarView registerClass:[ANZCalendarCell class] forCellWithReuseIdentifier:_cellID];
    
    [self addSubview:self.calendarView];
    
    [self sizeToFit];
    self.calendarView.backgroundColor = [UIColor whiteColor];
}

- (void)createCalendarFromDisplayDate:(NSDate *)displayDate
{
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
        [self.ds addObject: dataObj];
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
            [self.ds insertObject:dataObj atIndex:0];
        }
    }
    
    // 最終週の穴埋め
    NSUInteger numBlank = [self.ds count] % ANZCalendarNumDays;
    if (numBlank > 0) {
        // 元々の月の最終日に1日プラスで翌月初日
        NSDate* nextMonth = [finalDay dateByAddingTimeInterval:secondsDay];
        for (int i = 0; i < (ANZCalendarNumDays - numBlank); i++) {
            dataObj = [ANZCalendarDataObject new];
            dataObj.components = [_calendar components:flags fromDate:[nextMonth dateByAddingTimeInterval:secondsDay * i]];
            dataObj.isCurrentMonth = NO;
            dataObj.isFirstWeek = NO;
            dataObj.isLastWeek = YES;
            [self.ds addObject: dataObj];
        }
    }
}

- (void)dismiss
{
    // @todo
}

- (void)changeDisplayFormat
{
    // @todo
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.ds count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ANZCalendarCell* cell = (ANZCalendarCell *)[collectionView dequeueReusableCellWithReuseIdentifier:_cellID forIndexPath:indexPath];
    cell.data = ((ANZCalendarDataObject *)self.ds[indexPath.item]);
    
    return cell;
}

@end
