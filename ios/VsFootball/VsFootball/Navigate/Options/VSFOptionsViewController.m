//
//  VSFOptionsViewController.m
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFOptionsViewController.h"
#import "VSFPlaySelectionViewController.h"

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
    CGRect textFrame = textField.frame;
    float textY = textFrame.origin.y + textFrame.size.height;
    float bottomY = self.view.frame.size.height - textY;
    if (bottomY >= 216) {   // 216 is default keyboard height
        return;
    }
    float moveY = 216 - bottomY;
    prewMoveY = moveY;
    
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y -= moveY;
    frame.size.height += moveY;
    self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    float moveY;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    moveY =  prewMoveY;
    frame.origin.y += moveY;
    frame.size. height -= moveY;
    self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    [textField resignFirstResponder];
}

#pragma mark - private methods
- (void)defaultInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Vs. Football";
    self.navigationItem.backBarButtonItem.title = @"Back";

    NSString *opponentName = [[NSUserDefaults standardUserDefaults] objectForKey:@"OpponentName"];
    playerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(PLAYER_NAME_LABEL_X, PLAYER_NAME_LABEL_Y * SCREEN_HEIGHT, PLAYER_NAME_LABEL_W, PLAYER_NAME_LABEL_H * SCREEN_HEIGHT)];
    playerNameLabel.backgroundColor = [UIColor clearColor];
    playerNameLabel.textAlignment = NSTextAlignmentCenter;
    playerNameLabel.font = [UIFont fontWithName:@"Arial" size:17.];
    playerNameLabel.text = [NSString stringWithFormat:@"New game Vs. %@:", opponentName];
    [self.view addSubview:playerNameLabel];
    
    playSelectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(PLAY_SELECTION_LABEL_X, PLAY_SELECTION_LABEL_Y * SCREEN_HEIGHT, PLAY_SELECTION_LABEL_W, PLAY_SELECTION_LABEL_H * SCREEN_HEIGHT)];
    playSelectionLabel.backgroundColor = [UIColor clearColor];
    playSelectionLabel.textAlignment = NSTextAlignmentLeft;
    playSelectionLabel.font = [UIFont fontWithName:@"Arial" size:17.];
    playSelectionLabel.text = @"Do you want to start on:";
    [self.view addSubview:playSelectionLabel];
    
    offenseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    offenseButton.frame = CGRectMake(OFFENSIVE_BUTTON_X, OFFENSIVE_BUTTON_Y * SCREEN_HEIGHT, OFFENSIVE_BUTTON_W, OFFENSIVE_BUTTON_H * SCREEN_HEIGHT);
    [offenseButton setTitle:@"Offensive" forState:UIControlStateNormal];
    [offenseButton addTarget:self action:@selector(clickOnOffense) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:offenseButton];
    
    defenseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    defenseButton.frame = CGRectMake(DEFENSIVE_BUTTON_X, DEFENSIVE_BUTTON_Y * SCREEN_HEIGHT, DEFENSIVE_BUTTON_W, DEFENSIVE_BUTTON_H * SCREEN_HEIGHT);
    [defenseButton setTitle:@"Defense" forState:UIControlStateNormal];
    [defenseButton addTarget:self action:@selector(clickOnDefense) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:defenseButton];
    
    orLabel = [[UILabel alloc] initWithFrame:CGRectMake(OR_LABEL_X, OR_LABEL_Y * SCREEN_HEIGHT, OR_LABEL_W, OR_LABEL_H * SCREEN_HEIGHT)];
    orLabel.backgroundColor = [UIColor clearColor];
    orLabel.textAlignment = NSTextAlignmentCenter;
    orLabel.font = [UIFont fontWithName:@"Arial" size:17.];
    orLabel.text = @"or";
    [self.view addSubview:orLabel];
    
    noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(NOTE_LABEL_X, NOTE_LABEL_Y * SCREEN_HEIGHT, NOTE_LABEL_W, NOTE_LABEL_H * SCREEN_HEIGHT)];
    noteLabel.backgroundColor = [UIColor clearColor];
    noteLabel.textAlignment = NSTextAlignmentLeft;
    noteLabel.font = [UIFont fontWithName:@"Arial" size:14.];
    noteLabel.text = @"Note: You will be opposite for start of 2nd half";
    [self.view addSubview:noteLabel];
    
    enterTeamNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ENTER_TEAMNAME_LABEL_X, ENTER_TEAMNAME_LABEL_Y * SCREEN_HEIGHT, ENTER_TEAMNAME_LABEL_W, ENTER_TEAMNAME_LABEL_H * SCREEN_HEIGHT)];
    enterTeamNameLabel.backgroundColor = [UIColor clearColor];
    enterTeamNameLabel.textAlignment = NSTextAlignmentLeft;
    enterTeamNameLabel.font = [UIFont fontWithName:@"Arial" size:17.];
    enterTeamNameLabel.text = @"Enter your Team Name";
    [self.view addSubview:enterTeamNameLabel];
    
    teamNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(TEAMNAME_TEXTFIELD_X, TEAMNAME_TEXTFIELD_Y * SCREEN_HEIGHT, TEAMNAME_TEXTFIELD_W, TEAMNAME_TEXTFIELD_H * SCREEN_HEIGHT)];
    teamNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    teamNameTextField.keyboardType = UIKeyboardTypeDefault;
    teamNameTextField.returnKeyType = UIReturnKeyDone;
    teamNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    teamNameTextField.delegate = self;
    [self.view addSubview:teamNameTextField];
    NSString *previousTeamName;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PreviousTeamName"]) {
        previousTeamName = [[NSUserDefaults standardUserDefaults] objectForKey:@"PreviousTeamName"];
        teamNameTextField.text = previousTeamName;
    }

    callFirstPlayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    callFirstPlayButton.frame = CGRectMake(CALL_FIRST_PLAY_BUTTON_X, CALL_FIRST_PLAY_BUTTON_Y * SCREEN_HEIGHT, CALL_FIRST_PLAY_BUTTON_W, CALL_FIRST_PLAY_BUTTON_H * SCREEN_HEIGHT);
    [callFirstPlayButton setTitle:@"Call first play" forState:UIControlStateNormal];
    [callFirstPlayButton addTarget:self action:@selector(clickOnCallFirstPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callFirstPlayButton];
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
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"playSelectionType"]) {
        VSFPlaySelectionViewController *playSelectionViewController = [[VSFPlaySelectionViewController alloc] init];
        [self.navigationController pushViewController:playSelectionViewController animated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:@"You have not chose whether start on offense or defense" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
