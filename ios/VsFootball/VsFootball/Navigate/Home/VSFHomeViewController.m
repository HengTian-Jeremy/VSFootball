//
//  VSFHomeViewController.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFHomeViewController.h"

#import "VSFScoreboardView.h"

@interface VSFHomeViewController ()

- (void)initUI;
- (void)playbookClick;

@end

@implementation VSFHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initUI];
    
    [VSFScoreboardView getScoreboardView].delegate = self;
    [self.view addSubview:[VSFScoreboardView getScoreboardView]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
- (void)initUI
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBarHidden = YES;
}

- (void)playbookClick
{
    
}

#pragma mark - VSFScoreboardViewDelegate

- (void)pullUpScoreboard
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"pullup" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [VSFScoreboardView getScoreboardView].frame = CGRectMake(0, -80, 320, 100);
    [UIView commitAnimations];
}

- (void)pullDownScoreboard
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"pulldown" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [VSFScoreboardView getScoreboardView].frame = CGRectMake(0, 0, 320, 100);
    [UIView commitAnimations];
}

@end
