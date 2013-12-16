//
//  UtilsViewController.m
//  CommonSample
//
//  Created by ANZ on 2013/12/12.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "UtilsViewController.h"

#import "ANZUtils.h"

@interface UtilsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *current;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *select;

@end

@implementation UtilsViewController

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
    
    self.current.text = [ANZUtils curretnDateFormatYMD];
    [self.datePicker addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}

- (void)valueChanged
{
    self.select.text = [ANZUtils dateFormatYMD:self.datePicker.date];
}

@end
