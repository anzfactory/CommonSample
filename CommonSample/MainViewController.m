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

@interface MainViewController ()

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapDropDownField:(id)sender {
    [self.navigationController pushViewController:[DropDownViewController new] animated:YES];
}
- (IBAction)tapPropertiesList:(id)sender {
    [self.navigationController pushViewController:[PropertiesListViewController new] animated:YES];
}

@end
