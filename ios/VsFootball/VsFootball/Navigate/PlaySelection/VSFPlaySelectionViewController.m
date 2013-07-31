//
//  VSFPlaySelectionViewController.m
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlaySelectionViewController.h"

// Title label
#define TITLELABEL_X 0
#define TITLELABEL_Y 0
#define TITLELABEL_W 320
#define TITLELABEL_H 0.1
// Back  button
#define BACKBUTTON_X 10
#define BACKBUTTON_Y 0.02
#define BACKBUTTON_W 80
#define BACKBUTTON_H 0.07
// Tactics tableview
#define TACTICS_TABLEVIEW_X 10
#define TACTICS_TABLEVIEW_Y 0.25
#define TACTICS_TABLEVIEW_W 300
#define TACTICS_TABLEVIEW_H 0.7

@interface VSFPlaySelectionViewController ()

- (void)defaultInit;
- (void)clickOnBack;

@end

@implementation VSFPlaySelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self defaultInit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)defaultInit
{
    titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(TITLELABEL_X, TITLELABEL_Y * SCREEN_HEIGHT, TITLELABEL_W, TITLELABEL_H * SCREEN_HEIGHT)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:24.0f]];
    [self.view addSubview:titleLabel];
    
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setFrame:CGRectMake(BACKBUTTON_X, BACKBUTTON_Y * SCREEN_HEIGHT, BACKBUTTON_W, BACKBUTTON_H * SCREEN_HEIGHT)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickOnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)clickOnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
