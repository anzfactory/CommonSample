//
//  CalendarViewController.m
//  CommonSample
//
//  Created by ANZ on 2013/12/12.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "CalendarViewController.h"

#import "ANZCalendar.h"


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
    // Do any additional setup after loading the view from its nib.
//    ANZCalendar* calendar = [[ANZCalendar alloc] initWithFrame:CGRectMake(0, 100, 320, 260)];
//    [self.view addSubview:calendar];
    
    self.calndar = [[ANZCalendar alloc] initWithDisplayDate:[NSDate date]];

    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [[[ANZCalendar alloc] initWithDisplayDate:[NSDate date]] show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapShow:(id)sender {
    
    [self.calndar show];
    
}

@end
