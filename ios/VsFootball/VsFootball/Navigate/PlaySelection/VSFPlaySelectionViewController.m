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
#define BACKBUTTON_W 30
#define BACKBUTTON_H 0.07

@interface VSFPlaySelectionViewController ()

- (void)backButtonClick;

@end

@implementation VSFPlaySelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        titleLabel = [[UILabel alloc] init];
        [titleLabel setFrame:CGRectMake(TITLELABEL_X, TITLELABEL_Y * SCREEN_HEIGHT, TITLELABEL_W, TITLELABEL_H * SCREEN_HEIGHT)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:24.0f]];
        [self.view addSubview:titleLabel];
        
        backButton = [[UIButton alloc] init];
        [backButton setFrame:CGRectMake(BACKBUTTON_X, BACKBUTTON_Y * SCREEN_HEIGHT, BACKBUTTON_W, BACKBUTTON_H * SCREEN_HEIGHT)];
        backButton.backgroundColor = [UIColor blueColor];
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backButton];
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
- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
