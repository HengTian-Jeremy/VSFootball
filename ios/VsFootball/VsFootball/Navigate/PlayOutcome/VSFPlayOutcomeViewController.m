//
//  VSFPlayOutcomeViewController.m
//  VsFootball
//
//  Created by hjy on 8/1/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlayOutcomeViewController.h"

#import "VSFPlayOutcome.h"

// Play outcome view
#define PLAY_OUTCOME_VIEW_X 50
#define PLAY_OUTCOME_VIEW_Y 0.3
#define PLAY_OUTCOME_VIEW_W 220
#define PLAY_OUTCOME_VIEW_H 0.3

@interface VSFPlayOutcomeViewController ()

- (void)defaultInit;
- (void)showCombo:(NSTimer*)theTimer;

@end

@implementation VSFPlayOutcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self defaultInit];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
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
    [super defaultInit];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showResult:) userInfo:nil repeats:NO];
}

- (void)showResult:(NSTimer*)theTimer
{
    VSFPlayOutcome *playOutcomeView = [[VSFPlayOutcome alloc] initWithFrame:CGRectMake(PLAY_OUTCOME_VIEW_X, PLAY_OUTCOME_VIEW_Y * SCREEN_HEIGHT, PLAY_OUTCOME_VIEW_W, PLAY_OUTCOME_VIEW_H * SCREEN_HEIGHT)];
    [self.view addSubview:playOutcomeView];
}

@end
