//
//  VSFGameSummaryViewController.m
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFGameSummaryViewController.h"
#import "VSFAppDelegate.h"
#import "DDMenuController.h"
#import "VSFPlaybookViewController.h"
#import "VSFPlayAnimationViewController.h"
#import "VSFADBannerView.h"
#import "VSFScoreboardView.h"
#import "VSFPlaySelectionViewController.h"
#import "VSFCommonDefine.h"
#import "VSFADBannerView.h"

// Score board view
#define SCORE_BOARD_VIEW_Y 0
#define SCORE_BOARD_VIEW_H 0.2
// Game summary view
#define GAME_SUMMARY_VIEW_Y_ORIGIN 0.03
#define GAME_SUMMARY_VIEW_Y 0.25
#define GAME_SUMMARY_VIEW_H 0.89

@interface VSFGameSummaryViewController ()

- (void)defaultInit;
- (void)chatButtonClick;
- (void)backButtonClick;

@end

@implementation VSFGameSummaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
        backBarButtonItem.title = @"Back";
        backBarButtonItem.target = self;
        backBarButtonItem.action = @selector(backButtonClick);
        self.navigationItem.backBarButtonItem = backBarButtonItem;
        
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

- (void)viewWillAppear:(BOOL)animated
{
    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, self.view.bounds.size.height - 50, 320, 50);
    [self.view addSubview:[VSFADBannerView getAdBannerView]];
}

#pragma mark - private methods
- (void)defaultInit
{
    self.title = @"Vs. Football";
    
    UIBarButtonItem *chatButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chat_icon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(chatButtonClick)];
    self.navigationItem.rightBarButtonItem = chatButton;
    
    [VSFScoreboardView getScoreboardView].delegate = self;
    [VSFScoreboardView getScoreboardView].frame = CGRectMake(0, self.view.bounds.size.height * SCORE_BOARD_VIEW_Y, 320, self.view.bounds.size.height * SCORE_BOARD_VIEW_H);
    [UIView commitAnimations];
    [[VSFScoreboardView getScoreboardView] addHomeScore:14];
    [[VSFScoreboardView getScoreboardView] addAwayScore:3];
    [[VSFScoreboardView getScoreboardView] addPlayTime:@"12:28"];
    [[VSFScoreboardView getScoreboardView] addActionNumber:2 toGo:10 bo:38];
    [[VSFScoreboardView getScoreboardView] addLabel];
    [self.view addSubview:[VSFScoreboardView getScoreboardView]];
    
    gameSummaryView = [[VSFGameSummaryView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * GAME_SUMMARY_VIEW_Y, 320, self.view.frame.size.height * GAME_SUMMARY_VIEW_H)];
    gameSummaryView.delegate = self;
    [self.view addSubview:gameSummaryView];
}

- (void)chatButtonClick
{
    
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark - VSFScoreboardViewDelegate
//
//- (void)pullUpScoreboard
//{
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"pullup" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    [VSFScoreboardView getScoreboardView].frame = CGRectMake(0, self.view.bounds.size.height * SCORE_BOARD_VIEW_Y, 320, 20);
//    [[VSFScoreboardView getScoreboardView] removeSubviews];
//    [UIView commitAnimations];
//}
//
//- (void)pullDownScoreboard
//{
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"pulldown" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    [VSFScoreboardView getScoreboardView].frame = CGRectMake(0, self.view.bounds.size.height * SCORE_BOARD_VIEW_Y, 320, self.view.bounds.size.height * SCORE_BOARD_VIEW_H);
//    [UIView commitAnimations];
//    [[VSFScoreboardView getScoreboardView] addHomeScore:14];
//    [[VSFScoreboardView getScoreboardView] addAwayScore:3];
//    [[VSFScoreboardView getScoreboardView] addPlayTime:@"12:28"];
//    [[VSFScoreboardView getScoreboardView] addActionNumber:2 toGo:10 bo:38];
//    [[VSFScoreboardView getScoreboardView] addLabel];
//}

#pragma mark - VSFScoreboardViewDelegate
- (void)pullUpScoreboard
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"pullup" context:nil];
    [UIView setAnimationDuration:animationDuration];
    gameSummaryView.frame = CGRectMake(0, self.view.frame.size.height * GAME_SUMMARY_VIEW_Y_ORIGIN, 320, self.view.frame.size.height * GAME_SUMMARY_VIEW_H);
    [UIView commitAnimations];
}

- (void)pullDownScoreboard
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"pulldown" context:nil];
    [UIView setAnimationDuration:animationDuration];
    gameSummaryView.frame = CGRectMake(0, self.view.frame.size.height* GAME_SUMMARY_VIEW_Y, 320, self.view.frame.size.height * GAME_SUMMARY_VIEW_H);
    [UIView commitAnimations];
}

#pragma mark - VSFGameSummaryViewDelegate
- (void)instantReplay
{
    DDMenuController *loginMenuController = (DDMenuController *)((VSFAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    VSFPlayAnimationViewController *playAnimationViewController = [[VSFPlayAnimationViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:playAnimationViewController];
    [loginMenuController setRootController:navController animated:YES];
    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, SCREEN_HEIGHT - 20 - 44, 320, 50);
    [loginMenuController.view addSubview:[VSFADBannerView getAdBannerView]];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseNextPlay
{
    VSFPlaySelectionViewController *playSelectionController = [[VSFPlaySelectionViewController alloc] init];
    [self.navigationController pushViewController:playSelectionController animated:YES];
}

@end
