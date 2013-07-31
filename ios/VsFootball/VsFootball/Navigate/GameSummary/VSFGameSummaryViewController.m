//
//  VSFGameSummaryViewController.m
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFGameSummaryViewController.h"
#import "VSFScoreboardView.h"
#import "VSFPlaySelectionViewController.h"

// Title label
#define TITLELABEL_X 0
#define TITLELABEL_Y 0
#define TITLELABEL_W 320
#define TITLELABEL_H 0.1
// Menu icon button
#define EMNUBUTTON_X 10
#define EMNUBUTTON_Y 0.02
#define EMNUBUTTON_W 30
#define EMNUBUTTON_H 0.07
// Add icon button
#define ADDBUTTON_X (320 - EMNUBUTTON_X - ADDBUTTON_W)
#define ADDBUTTON_Y 0.02
#define ADDBUTTON_W 30
#define ADDBUTTON_H 0.07
// Score board view
#define SCORE_BOARD_VIEW_Y 0.1
#define SCORE_BOARD_VIEW_H 0.2
// Game summary view
#define GAME_SUMMARY_VIEW_Y_ORIGIN 0.11
#define GAME_SUMMARY_VIEW_Y 0.3
#define GAME_SUMMARY_VIEW_H 0.89

@interface VSFGameSummaryViewController ()

- (void)defaultInit;
- (void)menuIconButtonClick;
- (void)addIconButtonClick;

@end

@implementation VSFGameSummaryViewController

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
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(TITLELABEL_X, TITLELABEL_Y * SCREEN_HEIGHT, TITLELABEL_W, TITLELABEL_H * SCREEN_HEIGHT)];
    [titleLabel setText:@"Vs. Football"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:24.0f]];
    [self.view addSubview:titleLabel];
    
    UIButton *menuIconButton = [[UIButton alloc] init];
    [menuIconButton setFrame:CGRectMake(EMNUBUTTON_X, EMNUBUTTON_Y * SCREEN_HEIGHT, EMNUBUTTON_W, EMNUBUTTON_H * SCREEN_HEIGHT)];
    menuIconButton.backgroundColor = [UIColor blueColor];
    [menuIconButton setBackgroundImage:[UIImage imageNamed:@"menu_icon.png"] forState:UIControlStateNormal];
    [menuIconButton addTarget:self action:@selector(menuIconButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuIconButton];
    
    UIButton *addIconButton = [[UIButton alloc] init];
    [addIconButton setFrame:CGRectMake(ADDBUTTON_X, ADDBUTTON_Y * SCREEN_HEIGHT, ADDBUTTON_W, ADDBUTTON_H * SCREEN_HEIGHT)];
    addIconButton.backgroundColor = [UIColor blueColor];
    [addIconButton setBackgroundImage:[UIImage imageNamed:@"add_icon.png"] forState:UIControlStateNormal];
    [addIconButton addTarget:self action:@selector(addIconButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addIconButton];
    
    [VSFScoreboardView getScoreboardView].delegate = self;
    [VSFScoreboardView getScoreboardView].frame = CGRectMake(0, self.view.bounds.size.height * SCORE_BOARD_VIEW_Y, 320, self.view.bounds.size.height * SCORE_BOARD_VIEW_H);
    [UIView commitAnimations];
    [[VSFScoreboardView getScoreboardView] addHomeScore:14];
    [[VSFScoreboardView getScoreboardView] addAwayScore:3];
    [[VSFScoreboardView getScoreboardView] addPlayTime:@"12:28"];
    [[VSFScoreboardView getScoreboardView] addActionNumber:2 toGo:10 bo:38];
    [[VSFScoreboardView getScoreboardView] addLabel];
    [self.view addSubview:[VSFScoreboardView getScoreboardView]];
    
    NSLog(@"position=%f,%f,%f",SCREEN_HEIGHT * GAME_SUMMARY_VIEW_Y_ORIGIN, self.view.bounds.size.width, SCREEN_HEIGHT * GAME_SUMMARY_VIEW_H);
    gameSummaryView = [[VSFGameSummaryView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * GAME_SUMMARY_VIEW_Y_ORIGIN, 320, self.view.frame.size.height * GAME_SUMMARY_VIEW_H)];
    gameSummaryView.delegate = self;
    [self.view addSubview:gameSummaryView];
}

- (void)menuIconButtonClick
{
}

- (void)addIconButtonClick
{
    
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseNextPlay
{
    VSFPlaySelectionViewController *playSelectionController = [[VSFPlaySelectionViewController alloc] init];
    [self.navigationController pushViewController:playSelectionController animated:YES];
}

@end
