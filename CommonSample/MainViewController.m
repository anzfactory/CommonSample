//
//  MainViewController.m
//  CommonSample
//
//  Created by ANZ on 2013/12/04.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "MainViewController.h"

#import "DropDownViewController.h"
#import "PropertiesListViewController.h"
#import "UtilsViewController.h"
#import "CalendarViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *menuPicker;
@property (nonatomic) NSArray* ds;
@end

@implementation MainViewController

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
    
    self.menuPicker.delegate = self;
    self.menuPicker.dataSource = self;
    
    self.ds = @[[DropDownViewController class],
                [PropertiesListViewController class],
                [UtilsViewController class],
                [CalendarViewController class]];
    
    
    [self debug];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapMove:(id)sender {
    Class vcClass = self.ds[[self.menuPicker selectedRowInComponent:0]];
    [self.navigationController pushViewController:[vcClass new] animated:YES];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.ds count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return NSStringFromClass(self.ds[row]);
}

- (void)debug
{


}

@end
