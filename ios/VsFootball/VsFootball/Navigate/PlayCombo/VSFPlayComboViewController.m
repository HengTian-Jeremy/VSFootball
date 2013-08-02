//
//  VSFPlayComboViewController.m
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlayComboViewController.h"

#import "VSFADBannerView.h"

// Comment label
#define COMMENT_LABEL_X 0
#define COMMENT_LABEL_Y 0.02
#define COMMENT_LABEL_W 320
#define COMMENT_LABEL_H 0.1
// Defensive play label
#define DEFENSIVE_PLAY_LABEL_X 0
#define DEFENSIVE_PLAY_LABEL_Y 0.02
#define DEFENSIVE_PLAY_LABEL_W 1
#define DEFENSIVE_PLAY_LABEL_H 0.1
#define DEFENSIVE_PLAY_LABEL_WAITING_Y 0.45
// Offensive play label
#define OFFENSIVE_PLAY_LABEL_X 0
#define OFFENSIVE_PLAY_LABEL_Y 0.02
#define OFFENSIVE_PLAY_LABEL_W 1
#define OFFENSIVE_PLAY_LABEL_H 0.1
#define OFFENSIVE_PLAY_LABEL_WAITING_Y 0.45
// Defensive scroll view
#define DEFENSIVE_SCROLLVIEW_X 10
#define DEFENSIVE_SCROLLVIEW_Y 0.13
#define DEFENSIVE_SCROLLVIEW_W 300
#define DEFENSIVE_SCROLLVIEW_H 0.3
// Offensive scroll view
#define OFFENSIVE_SCROLLVIEW_X 10
#define OFFENSIVE_SCROLLVIEW_Y 0.43
#define OFFENSIVE_SCROLLVIEW_W 300
#define OFFENSIVE_SCROLLVIEW_H 0.3

@interface VSFPlayComboViewController ()

- (void)waitingForOppenentChoice:(NSTimer*)theTimer;

@end

@implementation VSFPlayComboViewController

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
        
        [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(waitingForOppenentChoice:) userInfo:nil repeats:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, self.view.bounds.size.height - 50, 320, 50);
    [self.view addSubview:[VSFADBannerView getAdBannerView]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)defaultInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(COMMENT_LABEL_X, COMMENT_LABEL_Y * SCREEN_HEIGHT, COMMENT_LABEL_W, COMMENT_LABEL_H * SCREEN_HEIGHT)];
    commentLabel.backgroundColor = [UIColor clearColor];
    commentLabel.text = @"\"Mike 55...Blue 25...Hut-Hut...\"";
    commentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:commentLabel];
    
    defensiveScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(DEFENSIVE_SCROLLVIEW_X, DEFENSIVE_SCROLLVIEW_Y * SCREEN_HEIGHT, DEFENSIVE_SCROLLVIEW_W, DEFENSIVE_SCROLLVIEW_H * SCREEN_HEIGHT)];
    defensiveScrollView.showsHorizontalScrollIndicator = YES;
    defensiveScrollView.delegate = self;
    defensiveScrollView.scrollEnabled = NO;
    [self.view addSubview:defensiveScrollView];
    
    offensiveScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(OFFENSIVE_SCROLLVIEW_X, OFFENSIVE_SCROLLVIEW_Y * SCREEN_HEIGHT, OFFENSIVE_SCROLLVIEW_W, OFFENSIVE_SCROLLVIEW_H * SCREEN_HEIGHT)];
    offensiveScrollView.showsHorizontalScrollIndicator = YES;
    offensiveScrollView.delegate = self;
    offensiveScrollView.scrollEnabled = NO;
    [self.view addSubview:offensiveScrollView];
    
    UIImageView *defensiveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEFENSIVE_SCROLLVIEW_W, DEFENSIVE_SCROLLVIEW_H * SCREEN_HEIGHT)];
    UIImageView *offensiveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, OFFENSIVE_SCROLLVIEW_Y, OFFENSIVE_SCROLLVIEW_H * SCREEN_HEIGHT)];
    [defensiveImageView setImage:[UIImage imageNamed:@"tactics"]];
    [offensiveImageView setImage:[UIImage imageNamed:@"tactics"]];
    [defensiveScrollView addSubview:defensiveImageView];
    [offensiveScrollView addSubview:offensiveImageView];
    
//    NSArray *imageArray=[NSArray arrayWithObjects:@"tactics",@"tactics",nil];
//    for(int i=0; i < imageArray.count; i++)
//    {
//        UIImageView *defensiveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DEFENSIVE_SCROLLVIEW_X * i, 0, DEFENSIVE_SCROLLVIEW_W, DEFENSIVE_SCROLLVIEW_H * SCREEN_HEIGHT)];
//        UIImageView *offensiveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(OFFENSIVE_SCROLLVIEW_X * i, 0, OFFENSIVE_SCROLLVIEW_Y, OFFENSIVE_SCROLLVIEW_H * SCREEN_HEIGHT)];
//        [defensiveImageView setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
//        [offensiveImageView setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
//        [defensiveScrollView addSubview:defensiveImageView];
//        [offensiveScrollView addSubview:offensiveImageView];
//    }
//    [self.view insertSubview:defensiveScrollView atIndex:0];
//    [self.view insertSubview:offensiveScrollView atIndex:0];
}

#pragma mark - private methods
- (void)waitingForOppenentChoice:(NSTimer*)theTimer
{
    
}

@end
