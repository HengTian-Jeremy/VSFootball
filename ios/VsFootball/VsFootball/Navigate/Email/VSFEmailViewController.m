//
//  VSFEmailViewController.m
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFEmailViewController.h"
#import "VSFInviteToJoinEntity.h"
#import "VSFUtility.h"

// Message label
#define MESSAGE_LABEL_X 40
#define MESSAGE_LABEL_Y 0.07
#define MESSAGE_LABEL_W 240
#define MESSAGE_LABEL_H 0.4
// Email textfield
#define EMAIL_TEXTFIELD_X 40
#define EMAIL_TEXTFIELD_Y 0.45
#define EMAIL_TEXTFIELD_W 240
#define EMAIL_TEXTFIELD_H 0.05
// Cancel button
#define CANCEL_BUTTON_X 40
#define CANCEL_BUTTON_Y 0.65
#define CANCEL_BUTTON_W 100
#define CANCEL_BUTTON_H 0.05
// Submit button
#define SUBMIT_BUTTON_X 180
#define SUBMIT_BUTTON_Y 0.65
#define SUBMIT_BUTTON_W 100
#define SUBMIT_BUTTON_H 0.05

@interface VSFEmailViewController ()

- (void)defaultInit;
- (void)clickOnCancel;
- (void)clickOnSubmit;

@end

@implementation VSFEmailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        process = [[VSFEmailProcess alloc] init];
        process.delegate = self;
        
        alertView = [[UIAlertView alloc] init];
        alertView.delegate = self;
        [alertView addButtonWithTitle:@"Ok"];
        
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
    [emailTextField resignFirstResponder];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - VSFEmailProcessDelegate
- (void)setInviteByEmailResult:(VSFInviteToJoinEntity *)respEntity
{
    if ([respEntity.success isEqualToString:@"false"]) {
        [alertView setTitle:@"Notice"];
        [alertView setMessage:respEntity.message];
        [alertView show];
        
        [Flurry logEvent:@"INVITE_TO_JOIN_FAILED"];
    } else if ([respEntity.success isEqualToString:@"true"]) {
        [alertView setTitle:@"Notice"];
        [alertView setMessage:respEntity.message];
        [alertView show];
        
        [Flurry logEvent:@"INVITE_TO_JOIN_SUCCESS"];
    }
}

#pragma mark - private methods
- (void)defaultInit
{
    self.title = @"Vs. Football";
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(MESSAGE_LABEL_X, MESSAGE_LABEL_Y * SCREEN_HEIGHT, MESSAGE_LABEL_W, MESSAGE_LABEL_H * SCREEN_HEIGHT)];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentLeft;
    messageLabel.text = @"Invite a friend to play!\n\nJust enter their email and\nwe'll send them an email with\na link to load the app and\nstart a game!";
    messageLabel.font = [UIFont fontWithName:@"SketchRockwell" size:17.0];
    messageLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:messageLabel];
    
    emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(EMAIL_TEXTFIELD_X, EMAIL_TEXTFIELD_Y * SCREEN_HEIGHT, EMAIL_TEXTFIELD_W, EMAIL_TEXTFIELD_H * SCREEN_HEIGHT)];
    emailTextField.placeholder = @"Email address";
    emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    emailTextField.returnKeyType = UIReturnKeyDone;
    emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTextField.delegate = self;
    [self.view addSubview:emailTextField];
    
    cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.frame = CGRectMake(CANCEL_BUTTON_X, CANCEL_BUTTON_Y * SCREEN_HEIGHT, CANCEL_BUTTON_W, CANCEL_BUTTON_H * SCREEN_HEIGHT);
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(clickOnCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitButton.frame = CGRectMake(SUBMIT_BUTTON_X, SUBMIT_BUTTON_Y * SCREEN_HEIGHT, SUBMIT_BUTTON_W, SUBMIT_BUTTON_H * SCREEN_HEIGHT);
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickOnSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];    
}

- (void)clickOnCancel
{
    emailTextField.text = @"";
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickOnSubmit
{
    NSString *email = [emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *validateResult = [VSFUtility validateVerificationEmailInfo:email];
    if ([validateResult isEqualToString:@"SUCCESS"]) {
        NSLog(@"Validate Success.");
        [process inviteByEmail: email];
    }else{
        alertView = [[UIAlertView alloc] initWithTitle:@"Notice"
                                               message:validateResult
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil, nil];
        [alertView show];
    }
}

@end
