//
//  VSFForgotPasswordViewController.m
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFForgotPasswordViewController.h"
#import "VSFUtility.h"
#import "VSFForgotPasswordResponseEntity.h"

// Title label
#define TITLE_LABEL_X 80.
#define TITLE_LABEL_Y 0.1
#define TITLE_LABEL_W 160.
#define TITLE_LABEL_H 0.07
// Message label
#define MESSAGE_LABEL_X 40.
#define MESSAGE_LABEL_Y 0.2
#define MESSAGE_LABEL_W 240.
#define MESSAGE_LABEL_H 0.3
// Email textfield
#define EMAIL_TEXTFIELD_X 40.
#define EMAIL_TEXTFIELD_Y 0.45
#define EMAIL_TEXTFIELD_W 240.
#define EMAIL_TEXTFIELD_H 0.06
// Cancel button
#define CANCEL_BUTTON_X 40.
#define CANCEL_BUTTON_Y 0.8
#define CANCEL_BUTTON_W 120.
#define CANCEL_BUTTON_H 0.06
// Submit button
#define SUBMIT_BUTTON_X 165.
#define SUBMIT_BUTTON_Y 0.8
#define SUBMIT_BUTTON_W 120.
#define SUBMIT_BUTTON_H 0.06

@interface VSFForgotPasswordViewController ()

- (void)defaultInit;
- (void)clickOnCancel;
- (void)clickOnSubmit;

@end

@implementation VSFForgotPasswordViewController

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
        process = [[VSFForgotPasswordProcess alloc] init];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - VSFForgotPasswordProcessDelegate
- (void)setForgotPasswordResult:(VSFForgotPasswordResponseEntity *)respEntity
{
    if ([respEntity.success isEqualToString:@"false"]) {
        [alertView setTitle:@"Notice"];
        [alertView setMessage:respEntity.message];
        [alertView show];
        
        [Flurry logEvent:@"SEND_PASSWORD_FAILED"];
    } else if ([respEntity.success isEqualToString:@"true"]) {
        [alertView setTitle:@"Notice"];
        [alertView setMessage:respEntity.message];
        [alertView show];
        
        [Flurry logEvent:@"SEND_PASSWORD_SUCCESS"];
    }
}

#pragma mark - private methods
- (void)defaultInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y * SCREEN_HEIGHT, TITLE_LABEL_W, TITLE_LABEL_H * SCREEN_HEIGHT)];
    titleLabel.text = @"Vs.Football";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30.0];
    [self.view addSubview:titleLabel];

    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(MESSAGE_LABEL_X, MESSAGE_LABEL_Y * SCREEN_HEIGHT, MESSAGE_LABEL_W, MESSAGE_LABEL_H * SCREEN_HEIGHT)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.text = @"Forgot your Password?\nJust enter your email and\nwe'll send you an email to\nreset it.";
    messageLabel.textAlignment = UITextAlignmentLeft;
    messageLabel.font = [UIFont systemFontOfSize:17.0];
    messageLabel.numberOfLines = 0;
    [self.view addSubview:messageLabel];
    
    emailTextField = [[UITextField alloc] init];
    emailTextField.frame = CGRectMake(EMAIL_TEXTFIELD_X, EMAIL_TEXTFIELD_Y * SCREEN_HEIGHT, EMAIL_TEXTFIELD_W, EMAIL_TEXTFIELD_H * SCREEN_HEIGHT);
    emailTextField.delegate = self;
    emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTextField.placeholder = @"Email address";
    emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickOnSubmit
{
    [emailTextField resignFirstResponder];
    
    NSString *email = [emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *validateResult = [VSFUtility validateVerificationEmailInfo:email];
    if ([validateResult isEqualToString:@"SUCCESS"]) {
        NSLog(@"Validate Success.");
        [process forgotPassword: email];
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
