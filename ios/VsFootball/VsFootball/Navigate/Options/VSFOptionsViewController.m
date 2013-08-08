//
//  VSFOptionsViewController.m
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFOptionsViewController.h"
#import "VSFPlaySelectionViewController.h"
#import "VSFCreateGameEntity.h"

// Scroll view
#define SCROLL_VIEW_W 320
#define SCROLL_VIEW_H 1.5
// Player name label
#define PLAYER_NAME_LABEL_X 0
#define PLAYER_NAME_LABEL_Y 0.05
#define PLAYER_NAME_LABEL_W 320
#define PLAYER_NAME_LABEL_H 0.05
// Play selection label
#define PLAY_SELECTION_LABEL_X 40
#define PLAY_SELECTION_LABEL_Y 0.15
#define PLAY_SELECTION_LABEL_W 240
#define PLAY_SELECTION_LABEL_H 0.05
// Offensive button
#define OFFENSIVE_BUTTON_X 40
#define OFFENSIVE_BUTTON_Y 0.25
#define OFFENSIVE_BUTTON_W 100
#define OFFENSIVE_BUTTON_H 0.05
// Defensive button
#define DEFENSIVE_BUTTON_X 180
#define DEFENSIVE_BUTTON_Y 0.25
#define DEFENSIVE_BUTTON_W 100
#define DEFENSIVE_BUTTON_H 0.05
// Or label
#define OR_LABEL_X 150
#define OR_LABEL_Y 0.25
#define OR_LABEL_W 20
#define OR_LABEL_H 0.05
// Note label
#define NOTE_LABEL_X 40
#define NOTE_LABEL_Y 0.32
#define NOTE_LABEL_W 240
#define NOTE_LABEL_H 0.05
// Enter team name label
#define ENTER_TEAMNAME_LABEL_X 40
#define ENTER_TEAMNAME_LABEL_Y 0.45
#define ENTER_TEAMNAME_LABEL_W 240
#define ENTER_TEAMNAME_LABEL_H 0.05
// Team name textfield
#define TEAMNAME_TEXTFIELD_X 40
#define TEAMNAME_TEXTFIELD_Y 0.55
#define TEAMNAME_TEXTFIELD_W 240
#define TEAMNAME_TEXTFIELD_H 0.05
// Call first play button
#define CALL_FIRST_PLAY_BUTTON_X 100
#define CALL_FIRST_PLAY_BUTTON_Y 0.7
#define CALL_FIRST_PLAY_BUTTON_W 120
#define CALL_FIRST_PLAY_BUTTON_H 0.05

@interface VSFOptionsViewController ()

- (void)defaultInit;
- (void)clickOnOffense;
- (void)clickOnDefense;
- (void)clickOnCallFirstPlay;

@end

@implementation VSFOptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        process = [[VSFOptionsProcess alloc] init];
        process.delegate = self;
        
        
        
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [teamNameTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView setScrollEnabled:YES];
    
    float moveY = 90;
    CGRect frame = scrollView.frame;
    frame.origin.y += moveY;
    frame.origin.x = 0;
    
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect frame = scrollView.frame;
    frame.origin.y = 0;
    frame.origin.x = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    [scrollView setScrollEnabled:NO];
    [textField resignFirstResponder];
}

#pragma mark - private methods
- (void)defaultInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Vs. Football";
    self.navigationItem.backBarButtonItem.title = @"Back";
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    [scrollView setContentSize:CGSizeMake(SCROLL_VIEW_W, SCROLL_VIEW_H * SCREEN_HEIGHT)];
    [scrollView setDelaysContentTouches:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollEnabled:NO];
    [self.view addSubview:scrollView];

    NSString *opponentName = [[NSUserDefaults standardUserDefaults] objectForKey:@"OpponentName"];
    playerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(PLAYER_NAME_LABEL_X, PLAYER_NAME_LABEL_Y * SCREEN_HEIGHT, PLAYER_NAME_LABEL_W, PLAYER_NAME_LABEL_H * SCREEN_HEIGHT)];
    playerNameLabel.backgroundColor = [UIColor clearColor];
    playerNameLabel.textAlignment = NSTextAlignmentCenter;
    playerNameLabel.font = [UIFont fontWithName:@"SketchRockwell" size:17.0];
    playerNameLabel.text = [NSString stringWithFormat:@"New game Vs. %@:", opponentName];
    [scrollView addSubview:playerNameLabel];
    
    playSelectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(PLAY_SELECTION_LABEL_X, PLAY_SELECTION_LABEL_Y * SCREEN_HEIGHT, PLAY_SELECTION_LABEL_W, PLAY_SELECTION_LABEL_H * SCREEN_HEIGHT)];
    playSelectionLabel.backgroundColor = [UIColor clearColor];
    playSelectionLabel.textAlignment = NSTextAlignmentLeft;
    playSelectionLabel.font = [UIFont fontWithName:@"SketchRockwell" size:17.0];
    playSelectionLabel.text = @"Do you want to start on:";
    [scrollView addSubview:playSelectionLabel];
    
    offenseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    offenseButton.frame = CGRectMake(OFFENSIVE_BUTTON_X, OFFENSIVE_BUTTON_Y * SCREEN_HEIGHT, OFFENSIVE_BUTTON_W, OFFENSIVE_BUTTON_H * SCREEN_HEIGHT);
    [offenseButton setTitle:@"Offensive" forState:UIControlStateNormal];
    [offenseButton addTarget:self action:@selector(clickOnOffense) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:offenseButton];
    
    defenseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    defenseButton.frame = CGRectMake(DEFENSIVE_BUTTON_X, DEFENSIVE_BUTTON_Y * SCREEN_HEIGHT, DEFENSIVE_BUTTON_W, DEFENSIVE_BUTTON_H * SCREEN_HEIGHT);
    [defenseButton setTitle:@"Defense" forState:UIControlStateNormal];
    [defenseButton addTarget:self action:@selector(clickOnDefense) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:defenseButton];
    
    orLabel = [[UILabel alloc] initWithFrame:CGRectMake(OR_LABEL_X, OR_LABEL_Y * SCREEN_HEIGHT, OR_LABEL_W, OR_LABEL_H * SCREEN_HEIGHT)];
    orLabel.backgroundColor = [UIColor clearColor];
    orLabel.textAlignment = NSTextAlignmentCenter;
    orLabel.font = [UIFont fontWithName:@"SketchRockwell" size:17.0];
    orLabel.text = @"or";
    [scrollView addSubview:orLabel];
    
    noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(NOTE_LABEL_X, NOTE_LABEL_Y * SCREEN_HEIGHT, NOTE_LABEL_W, NOTE_LABEL_H * SCREEN_HEIGHT)];
    noteLabel.backgroundColor = [UIColor clearColor];
    noteLabel.textAlignment = NSTextAlignmentLeft;
    noteLabel.font = [UIFont fontWithName:@"SketchRockwell" size:12.0];
    noteLabel.text = @"Note: You will be opposite for start of 2nd half";
    [scrollView addSubview:noteLabel];
    
    enterTeamNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ENTER_TEAMNAME_LABEL_X, ENTER_TEAMNAME_LABEL_Y * SCREEN_HEIGHT, ENTER_TEAMNAME_LABEL_W, ENTER_TEAMNAME_LABEL_H * SCREEN_HEIGHT)];
    enterTeamNameLabel.backgroundColor = [UIColor clearColor];
    enterTeamNameLabel.textAlignment = NSTextAlignmentLeft;
    enterTeamNameLabel.font = [UIFont fontWithName:@"SketchRockwell" size:17.0];
    enterTeamNameLabel.text = @"Enter your Team Name";
    [scrollView addSubview:enterTeamNameLabel];
    
    teamNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(TEAMNAME_TEXTFIELD_X, TEAMNAME_TEXTFIELD_Y * SCREEN_HEIGHT, TEAMNAME_TEXTFIELD_W, TEAMNAME_TEXTFIELD_H * SCREEN_HEIGHT)];
    teamNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    teamNameTextField.keyboardType = UIKeyboardTypeDefault;
    teamNameTextField.returnKeyType = UIReturnKeyDone;
    teamNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    teamNameTextField.delegate = self;
    [scrollView addSubview:teamNameTextField];
    NSString *previousTeamName;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PreviousTeamName"]) {
        previousTeamName = [[NSUserDefaults standardUserDefaults] objectForKey:@"PreviousTeamName"];
        teamNameTextField.text = previousTeamName;
    }

    callFirstPlayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    callFirstPlayButton.frame = CGRectMake(CALL_FIRST_PLAY_BUTTON_X, CALL_FIRST_PLAY_BUTTON_Y * SCREEN_HEIGHT, CALL_FIRST_PLAY_BUTTON_W, CALL_FIRST_PLAY_BUTTON_H * SCREEN_HEIGHT);
    [callFirstPlayButton setTitle:@"Call first play" forState:UIControlStateNormal];
    [callFirstPlayButton addTarget:self action:@selector(clickOnCallFirstPlay) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:callFirstPlayButton];
}

- (void)clickOnOffense
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"Offensive Play" forKey:@"playSelectionType"];
}

- (void)clickOnDefense
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"Defensive Play" forKey:@"playSelectionType"];
}

- (void)clickOnCallFirstPlay
{
    [process createGame:createGameEntity];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"playSelectionType"]) {
        VSFPlaySelectionViewController *playSelectionViewController = [[VSFPlaySelectionViewController alloc] init];
        [self.navigationController pushViewController:playSelectionViewController animated:YES];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:teamNameTextField.text forKey:@"PreviousTeamName"];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"You have not chose whether start on offense or defense" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
