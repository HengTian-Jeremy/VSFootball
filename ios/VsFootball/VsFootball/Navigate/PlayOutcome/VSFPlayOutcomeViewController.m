//
//  VSFPlayOutcomeViewController.m
//  VsFootball
//
//  Created by hjy on 8/1/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlayOutcomeViewController.h"

#import "VSFPlayOutcome.h"
#import "VSFGameSummaryViewController.h"
#import "DDMenuController.h"
#import "VSFPlaybookViewController.h"
#import "VSFAppDelegate.h"
#import "VSFPlayAnimationViewController.h"

// Play outcome view
#define PLAY_OUTCOME_VIEW_X 50
#define PLAY_OUTCOME_VIEW_Y 0.3
#define PLAY_OUTCOME_VIEW_W 220
#define PLAY_OUTCOME_VIEW_H 0.3
// Defensive scroll view
#define DEFENSIVE_SCROLLVIEW_X 10
#define DEFENSIVE_SCROLLVIEW_Y 0.05
#define DEFENSIVE_SCROLLVIEW_W 300
#define DEFENSIVE_SCROLLVIEW_H 0.3
// Offensive scroll view
#define OFFENSIVE_SCROLLVIEW_X 10
#define OFFENSIVE_SCROLLVIEW_Y 0.35
#define OFFENSIVE_SCROLLVIEW_W 300
#define OFFENSIVE_SCROLLVIEW_H 0.3
// Instant replay button
#define INSTANT_REPLAY_BUTTON_X 10
#define INSTANT_REPLAY_BUTTON_Y 0.75
#define INSTANT_REPLAY_BUTTON_W 140
#define INSTANT_REPLAY_BUTTON_H 0.05
// Game summary button
#define GAME_SUMMARY_BUTTON_X 170
#define GAME_SUMMARY_BUTTON_Y 0.75
#define GAME_SUMMARY_BUTTON_W 140
#define GAME_SUMMARY_BUTTON_H 0.05

@interface VSFPlayOutcomeViewController ()

- (void)defaultInit;
- (void)clickOnInstantReplay;
- (void)clickOnGameSummary;

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
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(showResult:) userInfo:nil repeats:NO];
    
    self.title = @"Vs. Football";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [offensiveImageView setImage:[UIImage imageNamed:@"tactics"]];
    [defensiveImageView setImage:[UIImage imageNamed:@"tactics"]];
    
    if (playType != nil) {
        if ([@"Offensive Play" isEqualToString: playType]){
            offensivePlayLabel.textColor = [UIColor whiteColor];
            offensivePlayLabel.text = [NSString stringWithFormat:@"%@", tacticsName];
            
            defensivePlayLabel.textColor = [UIColor whiteColor];
            defensivePlayLabel.text = @"4-3 Man";
        }else if([@"Defensive Play" isEqualToString: playType]) {
            [defensiveImageView setImage:[UIImage imageNamed:@"tactics"]];
            
            defensivePlayLabel.textColor = [UIColor whiteColor];
            defensivePlayLabel.text = [NSString stringWithFormat:@"%@", tacticsName];
            
            offensivePlayLabel.textColor = [UIColor whiteColor];
            offensivePlayLabel.text = @"HB LEAD";
        }
    }

    UIButton *instantReplayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    instantReplayButton.frame = CGRectMake(INSTANT_REPLAY_BUTTON_X, INSTANT_REPLAY_BUTTON_Y * SCREEN_HEIGHT, INSTANT_REPLAY_BUTTON_W, INSTANT_REPLAY_BUTTON_H * SCREEN_HEIGHT);
    [instantReplayButton setTitle:@"Instant Replay" forState:UIControlStateNormal];
    [instantReplayButton addTarget:self action:@selector(clickOnInstantReplay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:instantReplayButton];

    UIButton *gameSummaryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gameSummaryButton.frame = CGRectMake(GAME_SUMMARY_BUTTON_X, GAME_SUMMARY_BUTTON_Y * SCREEN_HEIGHT, GAME_SUMMARY_BUTTON_W, GAME_SUMMARY_BUTTON_H * SCREEN_HEIGHT);
    [gameSummaryButton setTitle:@"Game Summary" forState:UIControlStateNormal];
    [gameSummaryButton addTarget:self action:@selector(clickOnGameSummary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gameSummaryButton];
}

- (void)showResult:(NSTimer*)theTimer
{
    VSFPlayOutcome *playOutcomeView = [[VSFPlayOutcome alloc] initWithFrame:CGRectMake(PLAY_OUTCOME_VIEW_X, PLAY_OUTCOME_VIEW_Y * SCREEN_HEIGHT, PLAY_OUTCOME_VIEW_W, PLAY_OUTCOME_VIEW_H * SCREEN_HEIGHT)];
    [self.view addSubview:playOutcomeView];
}

- (void)clickOnInstantReplay
{
    VSFPlayAnimationViewController *playAnimationViewController = [[VSFPlayAnimationViewController alloc] init];
    DDMenuController *menuController = (DDMenuController *)((VSFAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:playAnimationViewController];
    [menuController setRootController:navController animated:YES];
}

- (void)clickOnGameSummary
{
    DDMenuController *menuController = (DDMenuController *)((VSFAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    VSFPlaybookViewController *playbookController = [[VSFPlaybookViewController alloc] init];
    menuController.leftViewController = playbookController;
    VSFGameSummaryViewController *gameSummaryViewController = [[VSFGameSummaryViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gameSummaryViewController];
    [menuController setRootController:navController animated:YES];
}

@end
