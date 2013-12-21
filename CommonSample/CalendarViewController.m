//
//  CalendarViewController.m
//  CommonSample
//
//  Created by ANZ on 2013/12/12.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "CalendarViewController.h"


@interface CalendarViewController ()

@property (nonatomic) ANZCalendar* calendar;

@end

@implementation CalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendar = [[ANZCalendar alloc] initWithDisplayDate:[NSDate date]];
    self.calendar.delegate = self;
//    self.calendar.colorLine = [UIColor blackColor];
//    self.calendar.colorSunday = [UIColor orangeColor];
//    self.calendar.colorSaturday = [UIColor greenColor];
//    self.calendar.colorWeekday = [UIColor lightGrayColor];
//    self.calendar.colorStrong = [UIColor purpleColor];
//    self.calendar.colorTopBar = [UIColor redColor];
//    self.calendar.colorNavigatorPrevMonth = [UIColor greenColor];
//    self.calendar.colorNavigatorNextMonth = [UIColor magentaColor];
    self.calendar.lengthRenew = 10.f;
    
//    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapShow:(id)sender {
    
    [self.calendar show];
    
}

- (void)showAfterWithCalendar:(ANZCalendar *)calendar
{
    NSLog(@"show after");
}

- (BOOL)isStrongDayWithDateComponents:(NSDateComponents *)dateComponents
{
    // とりあえずの返し
    return ([dateComponents day] % 6 == 0);
}
- (UIView *)accentStrongDayWithDateComponents:(NSDateComponents *)dateComponents cellSize:(CGSize)size
{
    if ([dateComponents day] % 5 != 0) {
        return nil;
    }
    
    UILabel* accent = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height - 20, size.width, 20)];
    accent.text = @"★";
    accent.font = [UIFont systemFontOfSize:12.f];
    accent.adjustsFontSizeToFitWidth = YES;
    accent.backgroundColor = [UIColor clearColor];
    accent.textColor = [UIColor purpleColor];
    accent.textAlignment = NSTextAlignmentRight;
    return accent;
}

- (void)willRenewCalendarWithNewDate:(NSDate *)newDate
{
    NSLog(@"new date :%@", newDate);
}


- (void)dismissAfter
{
    NSLog(@"dissmissafter");
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"touch b");
}

- (void)didSelectDay:(NSDateComponents *)dateComponents
{
    NSLog(@"select day:%@", dateComponents);
}

@end
