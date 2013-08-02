//
//  VSFPlayOutcomeViewController.m
//  VsFootball
//
//  Created by hjy on 8/1/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlayOutcomeViewController.h"
#import "VSFADBannerView.h"
#import "VSFPlayOutcome.h"

// Comment label
#define COMMENT_LABEL_X 0
#define COMMENT_LABEL_Y 0.02
#define COMMENT_LABEL_W 320
#define COMMENT_LABEL_H 0.1
// Run scroll view
#define RUN_SCROLLVIEW_X 10
#define RUN_SCROLLVIEW_Y 0.13
#define RUN_SCROLLVIEW_W 300
#define RUN_SCROLLVIEW_H 0.3
// Pass scroll view
#define PASS_SCROLLVIEW_X 10
#define PASS_SCROLLVIEW_Y 0.43
#define PASS_SCROLLVIEW_W 300
#define PASS_SCROLLVIEW_H 0.3
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(COMMENT_LABEL_X, COMMENT_LABEL_Y * SCREEN_HEIGHT, COMMENT_LABEL_W, COMMENT_LABEL_H * SCREEN_HEIGHT)];
    commentLabel.backgroundColor = [UIColor clearColor];
    commentLabel.text = @"\"Mike 55...Blue 25...Hut-Hut...\"";
    commentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:commentLabel];
    
    runScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(RUN_SCROLLVIEW_X, RUN_SCROLLVIEW_Y * SCREEN_HEIGHT, RUN_SCROLLVIEW_W, RUN_SCROLLVIEW_H * SCREEN_HEIGHT)];
    runScrollView.showsHorizontalScrollIndicator = YES;
    runScrollView.delegate = self;
    runScrollView.scrollEnabled = YES;
    runScrollView.contentSize = CGSizeMake(RUN_SCROLLVIEW_W * 2, RUN_SCROLLVIEW_H * SCREEN_HEIGHT);
    
    passScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(PASS_SCROLLVIEW_X, PASS_SCROLLVIEW_Y * SCREEN_HEIGHT, PASS_SCROLLVIEW_W, PASS_SCROLLVIEW_H * SCREEN_HEIGHT)];
    passScrollView.showsHorizontalScrollIndicator = YES;
    passScrollView.delegate = self;
    passScrollView.scrollEnabled = YES;
    passScrollView.contentSize = CGSizeMake(PASS_SCROLLVIEW_W * 2, PASS_SCROLLVIEW_H * SCREEN_HEIGHT);
    
    NSArray *imageArray=[NSArray arrayWithObjects:@"tactics",@"tactics",nil];
    for(int i=0; i < imageArray.count; i++)
    {
        UIImageView *runImageView = [[UIImageView alloc]initWithFrame:CGRectMake(RUN_SCROLLVIEW_W * i, 0, RUN_SCROLLVIEW_W, RUN_SCROLLVIEW_H * SCREEN_HEIGHT)];
        UIImageView *passImageView = [[UIImageView alloc]initWithFrame:CGRectMake(PASS_SCROLLVIEW_W * i, 0, PASS_SCROLLVIEW_W, PASS_SCROLLVIEW_H * SCREEN_HEIGHT)];
        [runImageView setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
        [passImageView setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
        [runScrollView addSubview:runImageView];
        [passScrollView addSubview:passImageView];
    }
    [self.view insertSubview:runScrollView atIndex:0];
    [self.view insertSubview:passScrollView atIndex:0];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showCombo:) userInfo:nil repeats:NO];
}

- (void)showCombo:(NSTimer*)theTimer
{
    VSFPlayOutcome *playOutcomeView = [[VSFPlayOutcome alloc] initWithFrame:CGRectMake(PLAY_OUTCOME_VIEW_X, PLAY_OUTCOME_VIEW_Y * SCREEN_HEIGHT, PLAY_OUTCOME_VIEW_W, PLAY_OUTCOME_VIEW_H * SCREEN_HEIGHT)];
    [self.view addSubview:playOutcomeView];
}

@end
