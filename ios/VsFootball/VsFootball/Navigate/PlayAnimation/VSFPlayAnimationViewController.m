//
//  VSFPlayAnimationViewController.m
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlayAnimationViewController.h"
#import "VSFPlayOutcomeViewController.h"
#import "DDMenuController.h"
#import "VSFPlaybookViewController.h"
#import "VSFAppDelegate.h"

// Animation view
#define ANIMATION_VIEW_X 0
#define ANIMATION_VIEW_Y 0
#define ANIMATION_VIEW_W 320
#define ANIMATION_VIEW_H 0.8
// Animation label
#define ANIMATION_LABEL_X 0
#define ANIMATION_LABEL_Y 0
#define ANIMATION_LABEL_W 320
#define ANIMATION_LABEL_H 0.8
// Replay button
#define REPLAY_BUTTON_X 64
#define REPLAY_BUTTON_Y 0.8
#define REPLAY_BUTTON_W 64
#define REPLAY_BUTTON_H 0.1
// Skip button
#define SKIP_BUTTON_X 192
#define SKIP_BUTTON_Y 0.8
#define SKIP_BUTTON_W 64
#define SKIP_BUTTON_H 0.1

@interface VSFPlayAnimationViewController ()

- (void)defaultInit;
- (void)clickOnReplay;
- (void)clickOnSkip;

@end

@implementation VSFPlayAnimationViewController

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
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(ANIMATION_VIEW_X, ANIMATION_VIEW_Y * SCREEN_HEIGHT, ANIMATION_VIEW_W, ANIMATION_VIEW_H * SCREEN_HEIGHT)];
    animationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:animationView];
    
    UILabel *animationLabel = [[UILabel alloc] initWithFrame:CGRectMake(ANIMATION_LABEL_X, ANIMATION_LABEL_Y * SCREEN_HEIGHT, ANIMATION_LABEL_W, ANIMATION_LABEL_H * SCREEN_HEIGHT)];
    animationLabel.backgroundColor = [UIColor clearColor];
    animationLabel.textAlignment = NSTextAlignmentCenter;
    animationLabel.numberOfLines = 0;
    animationLabel.text = @"Full-screen animation\nplays hers!\n\n\nWe need smooth transition from the\nend of animation(s) to the Play\nOutcome page";
    [self.view addSubview:animationLabel];
    
    UIButton *replayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    replayButton.frame = CGRectMake(REPLAY_BUTTON_X, REPLAY_BUTTON_Y * SCREEN_HEIGHT, REPLAY_BUTTON_W, REPLAY_BUTTON_H * SCREEN_HEIGHT);
    [replayButton setTitle:@"Replay" forState:UIControlStateNormal];
    [replayButton addTarget:self action:@selector(clickOnReplay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:replayButton];
    
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    skipButton.frame = CGRectMake(SKIP_BUTTON_X, SKIP_BUTTON_Y * SCREEN_HEIGHT, SKIP_BUTTON_W, SKIP_BUTTON_H * SCREEN_HEIGHT);
    [skipButton setTitle:@"Skip" forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(clickOnSkip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipButton];
}

- (void)clickOnReplay
{
    
}

- (void)clickOnSkip
{
    DDMenuController *menuController = (DDMenuController *)((VSFAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    VSFPlaybookViewController *playbookController = [[VSFPlaybookViewController alloc] init];
    menuController.leftViewController = playbookController;
    VSFPlayOutcomeViewController *playOutcomeViewController = [[VSFPlayOutcomeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:playOutcomeViewController];
    [menuController setRootController:navController animated:YES];
}

@end
