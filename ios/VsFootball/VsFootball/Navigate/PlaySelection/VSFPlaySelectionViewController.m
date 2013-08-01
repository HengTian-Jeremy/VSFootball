//
//  VSFPlaySelectionViewController.m
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlaySelectionViewController.h"

// Tactics tableview
#define TACTICS_TABLEVIEW_X 10
#define TACTICS_TABLEVIEW_Y 0.25
#define TACTICS_TABLEVIEW_W 300
#define TACTICS_TABLEVIEW_H 0.7

@interface VSFPlaySelectionViewController ()

- (void)defaultInit;

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
    self.title = @"Offensive Play";
}

@end
