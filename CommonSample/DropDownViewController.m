//
//  DropDownViewController.m
//  CommonSample
//
//  Created by ANZ on 2013/12/04.
//  Copyright (c) 2013年 ANZ. All rights reserved.
//

#import "DropDownViewController.h"

#import "ANZDropDownField.h"

@interface DropDownViewController ()
@property (weak, nonatomic) IBOutlet ANZDropDownField *smapleField;
@end

@implementation DropDownViewController

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
    self.smapleField.dropList = @[@"item 1",@"item 2",@"item 3",@"item 4",@"item 5",@"item 6",@"item 7",@"item 8",@"item 9",@"item 10"];
    
    ANZDropDownField* newAnz = [[ANZDropDownField alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 35, 200, 30)];
    newAnz.text = @"";
    newAnz.borderStyle = UITextBorderStyleRoundedRect;
    newAnz.dropList = self.smapleField.dropList;
    newAnz.heightOfListItem = 10.f;
    newAnz.displayNumOfRows = 3;
    newAnz.fontOfListItem =  [UIFont fontWithName:@"Courier" size:[UIFont systemFontSize]];
    newAnz.borderColorForList = [UIColor redColor];
    [self.view addSubview:newAnz];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
