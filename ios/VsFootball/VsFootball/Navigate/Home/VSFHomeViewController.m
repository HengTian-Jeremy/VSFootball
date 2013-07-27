//
//  VSFHomeViewController.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFHomeViewController.h"
#import "VSFScoreboardView.h"

// BackGround Image
#define BACKGROUND_IMAGE_X 0
#define BACKGROUND_IMAGE_Y 0
#define BACKGROUND_IMAGE_W 320
#define BACKGROUND_IMAGE_H 1
// Go back button
#define GOBACK_BUTTON_X 50
#define GOBACK_BUTTON_Y 0.07
#define GOBACK_BUTTON_W 60
#define GOBACK_BUTTON_H 0.06

@interface VSFHomeViewController ()

- (void)initUI;
- (void)playbookClick;
- (void)clickOnBackButton;

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
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BACKGROUND_IMAGE_X,
                                                                               BACKGROUND_IMAGE_Y * SCREEN_HEIGHT,
                                                                               BACKGROUND_IMAGE_W,
                                                                               BACKGROUND_IMAGE_H * SCREEN_HEIGHT)];
    [backImageView setImage:[UIImage imageNamed:@"bg_1.jpg"]];
    [self.view addSubview:backImageView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setFrame:CGRectMake(GOBACK_BUTTON_X,
                                    GOBACK_BUTTON_Y * SCREEN_HEIGHT,
                                    GOBACK_BUTTON_W,
                                    GOBACK_BUTTON_H * SCREEN_HEIGHT)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickOnBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}

- (void)playbookClick
{
    
}

- (void)clickOnBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
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
