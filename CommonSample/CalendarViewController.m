//
//  CalendarViewController.m
//  CommonSample
//
//  Created by ANZ on 2013/12/12.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "CalendarViewController.h"


@interface CalendarViewController ()

@property (nonatomic) ANZCalendar* calndar;

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
    
    self.calndar = [[ANZCalendar alloc] initWithDisplayDate:[NSDate date]];
    self.calndar.delegate = self;
//    self.calndar.colorLine = [UIColor blackColor];
//    self.calndar.colorSunday = [UIColor orangeColor];
//    self.calndar.colorSaturday = [UIColor greenColor];
//    self.calndar.colorWeekday = [UIColor lightGrayColor];
//    self.calndar.colorStrong = [UIColor purpleColor];
//    self.calndar.colorTopBar = [UIColor redColor];
//    self.calndar.colorNavigatorPrevMonth = [UIColor greenColor];
//    self.calndar.colorNavigatorNextMonth = [UIColor magentaColor];
    
//    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapShow:(id)sender {
    
    [self.calndar show];
    
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
