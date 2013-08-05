//
//  VSFPlayComboViewController.m
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlayComboViewController.h"

#import "VSFADBannerView.h"
#import "VSFPlayAnimationViewController.h"

// Comment label
#define COMMENT_LABEL_X 0
#define COMMENT_LABEL_Y 0.02
#define COMMENT_LABEL_W 320
#define COMMENT_LABEL_H 0.1
// Defensive play label
#define DEFENSIVE_PLAY_LABEL_X 0
#define DEFENSIVE_PLAY_LABEL_Y 0.02
#define DEFENSIVE_PLAY_LABEL_W 1
#define DEFENSIVE_PLAY_LABEL_H 0.6
#define DEFENSIVE_PLAY_LABEL_WAITING_Y 0.3
// Offensive play label
#define OFFENSIVE_PLAY_LABEL_X 0
#define OFFENSIVE_PLAY_LABEL_Y 0.02
#define OFFENSIVE_PLAY_LABEL_W 1
#define OFFENSIVE_PLAY_LABEL_H 0.6
#define OFFENSIVE_PLAY_LABEL_WAITING_Y 0.3
// Defensive scroll view
#define DEFENSIVE_SCROLLVIEW_X 10
#define DEFENSIVE_SCROLLVIEW_Y 0.11
#define DEFENSIVE_SCROLLVIEW_W 300
#define DEFENSIVE_SCROLLVIEW_H 0.3
// Offensive scroll view
#define OFFENSIVE_SCROLLVIEW_X 10
#define OFFENSIVE_SCROLLVIEW_Y 0.43
#define OFFENSIVE_SCROLLVIEW_W 300
#define OFFENSIVE_SCROLLVIEW_H 0.3

@interface VSFPlayComboViewController ()

- (void)defaultInit;
- (void)waitingForOppenentChoice:(NSTimer*)theTimer;
- (void)showPlayAnimation:(NSTimer*)theTimer;

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    
    defensiveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEFENSIVE_SCROLLVIEW_W, DEFENSIVE_SCROLLVIEW_H * SCREEN_HEIGHT)];
    defensiveImageView.backgroundColor = [UIColor whiteColor];
    [defensiveScrollView addSubview:defensiveImageView];
    
    offensiveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, OFFENSIVE_SCROLLVIEW_W, OFFENSIVE_SCROLLVIEW_H * SCREEN_HEIGHT)];
    offensiveImageView.backgroundColor = [UIColor whiteColor];
    [offensiveScrollView addSubview:offensiveImageView];
    
    defensivePlayLabel = [[UILabel alloc] initWithFrame:CGRectMake(DEFENSIVE_PLAY_LABEL_X * defensiveImageView.frame.size.width, DEFENSIVE_PLAY_LABEL_Y * defensiveImageView.frame.size.height, DEFENSIVE_PLAY_LABEL_W * defensiveImageView.frame.size.width, DEFENSIVE_PLAY_LABEL_H * defensiveImageView.frame.size.height)];
    defensivePlayLabel.backgroundColor = [UIColor clearColor];
    defensivePlayLabel.textAlignment = NSTextAlignmentCenter;
    [defensiveImageView addSubview:defensivePlayLabel];
    
    offensivePlayLabel = [[UILabel alloc] initWithFrame:CGRectMake(OFFENSIVE_PLAY_LABEL_X * offensiveImageView.frame.size.width, OFFENSIVE_PLAY_LABEL_Y * offensiveImageView.frame.size.height, OFFENSIVE_PLAY_LABEL_W * offensiveImageView.frame.size.width, OFFENSIVE_PLAY_LABEL_H * offensiveImageView.frame.size.height)];
    offensivePlayLabel.backgroundColor = [UIColor clearColor];
    offensivePlayLabel.textAlignment = NSTextAlignmentCenter;
    [offensiveImageView addSubview:offensivePlayLabel];
    
    playType = [[NSUserDefaults standardUserDefaults] objectForKey:@"playSelectionType"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    tacticsName = [userDefaults objectForKey:@"playTacticsName"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)defaultInit
{
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(waitingForOppenentChoice:) userInfo:nil repeats:NO];
    
    self.title = @"Vs. Football";
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (playType != nil) {
        if ([@"Offensive Play" isEqualToString: playType]){
            [offensiveImageView setImage:[UIImage imageNamed:@"tactics"]];
            
            offensivePlayLabel.textColor = [UIColor whiteColor];
            offensivePlayLabel.text = [NSString stringWithFormat:@"%@", tacticsName];
            
            defensivePlayLabel.textColor = [UIColor blackColor];
            defensivePlayLabel.text = @"Waiting for opponent to\n select their play";
            defensivePlayLabel.numberOfLines = 0;
            defensivePlayLabel.frame = CGRectMake(DEFENSIVE_PLAY_LABEL_X * defensiveImageView.frame.size.width, DEFENSIVE_PLAY_LABEL_WAITING_Y * defensiveImageView.frame.size.height, DEFENSIVE_PLAY_LABEL_W * defensiveImageView.frame.size.width, DEFENSIVE_PLAY_LABEL_H * defensiveImageView.frame.size.height);
        }else if([@"Defensive Play" isEqualToString: playType]) {
            [defensiveImageView setImage:[UIImage imageNamed:@"tactics"]];
            
            defensivePlayLabel.textColor = [UIColor whiteColor];
            defensivePlayLabel.text = [NSString stringWithFormat:@"%@", tacticsName];
            
            offensivePlayLabel.textColor = [UIColor blackColor];
            offensivePlayLabel.text = @"Waiting for opponent to\n select their play";
            offensivePlayLabel.numberOfLines = 0;
            offensivePlayLabel.frame = CGRectMake(OFFENSIVE_PLAY_LABEL_X * offensiveImageView.frame.size.width, OFFENSIVE_PLAY_LABEL_WAITING_Y * offensiveImageView.frame.size.height, OFFENSIVE_PLAY_LABEL_W * offensiveImageView.frame.size.width, OFFENSIVE_PLAY_LABEL_H * offensiveImageView.frame.size.height);
        }
    }
    
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
    commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(COMMENT_LABEL_X, COMMENT_LABEL_Y * SCREEN_HEIGHT, COMMENT_LABEL_W, COMMENT_LABEL_H * SCREEN_HEIGHT)];
    commentLabel.backgroundColor = [UIColor clearColor];
    commentLabel.text = @"\"Mike 55...Blue 25...Hut-Hut...\"";
    commentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:commentLabel];
    
    if (playType != nil) {
        if ([@"Defensive Play" isEqualToString: playType]){
            [offensiveImageView setImage:[UIImage imageNamed:@"tactics"]];
            
            offensivePlayLabel.frame = CGRectMake(OFFENSIVE_PLAY_LABEL_X * offensiveImageView.frame.size.width, OFFENSIVE_PLAY_LABEL_Y * offensiveImageView.frame.size.height, OFFENSIVE_PLAY_LABEL_W * offensiveImageView.frame.size.width, OFFENSIVE_PLAY_LABEL_H * offensiveImageView.frame.size.height);
            offensivePlayLabel.textColor = [UIColor whiteColor];
            offensivePlayLabel.text = @"HB LEAD";
        }else if([@"Offensive Play" isEqualToString: playType]) {
            [defensiveImageView setImage:[UIImage imageNamed:@"tactics"]];
            
            defensivePlayLabel.frame = CGRectMake(DEFENSIVE_PLAY_LABEL_X * defensiveImageView.frame.size.width, DEFENSIVE_PLAY_LABEL_Y * defensiveImageView.frame.size.height, DEFENSIVE_PLAY_LABEL_W * defensiveImageView.frame.size.width, DEFENSIVE_PLAY_LABEL_H * defensiveImageView.frame.size.height);
            defensivePlayLabel.textColor = [UIColor whiteColor];
            defensivePlayLabel.text = @"4-3 Man";
        }
    }
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(showPlayAnimation:) userInfo:nil repeats:NO];
}

- (void)showPlayAnimation:(NSTimer*)theTimer
{
    VSFPlayAnimationViewController *playAnimationController = [[VSFPlayAnimationViewController alloc] init];
    [self.navigationController pushViewController:playAnimationController animated:YES];
}

@end
