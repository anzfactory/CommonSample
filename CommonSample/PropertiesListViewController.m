//
//  PropertiesListViewController.m
//  CommonSample
//
//  Created by ANZ on 2013/12/09.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "PropertiesListViewController.h"

#import "NSObject+Custom.h"

@interface PropertiesListViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation PropertiesListViewController

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
    self.textView.text = [[self properties] description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
