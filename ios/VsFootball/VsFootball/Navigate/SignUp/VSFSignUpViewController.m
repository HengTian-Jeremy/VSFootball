//
//  VSFSignUpViewController.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFSignUpViewController.h"

#import "VSFSignUpProcess.h"
#import "VSFUtility.h"
#import "VSFSignUpEntity.h"
#import "VSFSignUpResponseEntity.h"
#import "VSFLoginViewController.h"

// Email TextField
#define EMAILTEXT_X 60
#define EMAILTEXT_Y 0.15
#define EMAILTEXT_W 200
#define EMAILTEXT_H 0.06
// Password TextField
#define PASSWORDTEXT_X 60
#define PASSWORDTEXT_Y 0.25
#define PASSWORDTEXT_W 200
#define PASSWORDTEXT_H 0.06
// Confirm Password TextField
#define CONFIRMPASSWORDTEXT_X 60
#define CONFIRMPASSWORDTEXT_Y 0.35
#define CONFIRMPASSWORDTEXT_W 200
#define CONFIRMPASSWORDTEXT_H 0.06
// Firstname TextField
#define FIRSTNAMETEXT_X 60
#define FIRSTNAMETEXT_Y 0.45
#define FIRSTNAMETEXT_W 200
#define FIRSTNAMETEXT_H 0.06
// Lastname TextField
#define LASTNAMETEXT_X 60
#define LASTNAMETEXT_Y 0.55
#define LASTNAMETEXT_W 200
#define LASTNAMETEXT_H 0.06
// Sign Up button
#define SIGNUPBUTTON_X 170
#define SIGNUPBUTTON_Y 0.65
#define SIGNUPBUTTON_W 120
#define SIGNUPBUTTON_H 0.06
// Go back button
#define BACKBUTTON_X 30
#define BACKBUTTON_Y 0.65
#define BACKBUTTON_W 120
#define BACKBUTTON_H 0.06
// Title Label
#define TITLE_LABEL_X 0
#define TITLE_LABEL_Y 0.015
#define TITLE_LABEL_W 320
#define TITLE_LABEL_H 0.1
// Your account info Label
#define ACCOUNT_INFO_LABEL_X 20
#define ACCOUNT_INFO_LABEL_Y 0.1
#define ACCOUNT_INFO_LABEL_W 160
#define ACCOUNT_INFO_LABEL_H 0.05
// Tip Label
#define TIP_LABEL_X 20
#define TIP_LABEL_Y 0.75
#define TIP_LABEL_W 280
#define TIP_LABEL_H 0.15
// ScrollView for Main of ContentSize
#define SCROLL_VIEW_W 320
#define SCROLL_VIEW_H 1.5

@interface VSFSignUpViewController ()

- (void)initUI;
- (void)signUpButtonClick;
- (void)clickOnBackButton;
- (void)endEditing;

@end

@implementation VSFSignUpViewController

@synthesize delegate;

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
        process = [[VSFSignUpProcess alloc] init];
        process.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Private Methods

- (void)initUI
{
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setContentSize:CGSizeMake(SCROLL_VIEW_W, SCROLL_VIEW_H * SCREEN_HEIGHT)];
    [scrollView setDelaysContentTouches:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollEnabled:NO];
    [self.view addSubview:scrollView];
    
    emailText = [[UITextField alloc] init];
    emailText.frame = CGRectMake(EMAILTEXT_X, EMAILTEXT_Y * SCREEN_HEIGHT, EMAILTEXT_W, EMAILTEXT_H * SCREEN_HEIGHT);
    emailText.borderStyle = UITextBorderStyleBezel;
    emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailText.placeholder = @"Email";
    [scrollView addSubview:emailText];
    
    passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(PASSWORDTEXT_X, PASSWORDTEXT_Y * SCREEN_HEIGHT, PASSWORDTEXT_W, PASSWORDTEXT_H * SCREEN_HEIGHT);
    passwordText.borderStyle = UITextBorderStyleBezel;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordText.placeholder = @"Password";
    passwordText.secureTextEntry = YES;
    [scrollView addSubview:passwordText];
    
    confirmPasswordText = [[UITextField alloc] init];
    confirmPasswordText.frame = CGRectMake(CONFIRMPASSWORDTEXT_X, CONFIRMPASSWORDTEXT_Y * SCREEN_HEIGHT, CONFIRMPASSWORDTEXT_W, CONFIRMPASSWORDTEXT_H * SCREEN_HEIGHT);
    confirmPasswordText.borderStyle = UITextBorderStyleBezel;
    confirmPasswordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmPasswordText.placeholder = @"Confirm Password";
    confirmPasswordText.secureTextEntry = YES;
    [scrollView addSubview:confirmPasswordText];
    
    firstnameText = [[UITextField alloc] init];
    firstnameText.frame = CGRectMake(FIRSTNAMETEXT_X, FIRSTNAMETEXT_Y * SCREEN_HEIGHT, FIRSTNAMETEXT_W, FIRSTNAMETEXT_H * SCREEN_HEIGHT);
    firstnameText.borderStyle = UITextBorderStyleBezel;
    firstnameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstnameText.placeholder = @"Firstname";
    firstnameText.tag = 1;
    [scrollView addSubview:firstnameText];
    
    lastnameText = [[UITextField alloc] init];
    lastnameText.frame = CGRectMake(LASTNAMETEXT_X, LASTNAMETEXT_Y * SCREEN_HEIGHT, LASTNAMETEXT_W, LASTNAMETEXT_H * SCREEN_HEIGHT);
    lastnameText.borderStyle = UITextBorderStyleBezel;
    lastnameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastnameText.placeholder = @"Lastname";
    lastnameText.delegate = self;  // lastnameText will be covered by keyboard when writting
    lastnameText.tag = 2;
    [scrollView addSubview:lastnameText];
    
    signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUpButton.frame = CGRectMake(SIGNUPBUTTON_X, SIGNUPBUTTON_Y * SCREEN_HEIGHT, SIGNUPBUTTON_W, SIGNUPBUTTON_H * SCREEN_HEIGHT);
    [signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(signUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:signUpButton];
    
    UIButton *goBackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goBackButton.frame = CGRectMake(BACKBUTTON_X, BACKBUTTON_Y * SCREEN_HEIGHT, BACKBUTTON_W, BACKBUTTON_H * SCREEN_HEIGHT);
    [goBackButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [goBackButton addTarget:self action:@selector(clickOnBackButton) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:goBackButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y * SCREEN_HEIGHT, TITLE_LABEL_W, TITLE_LABEL_H * SCREEN_HEIGHT)];
    titleLabel.text = @"Vs. Football";
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:24.0];
    [scrollView addSubview:titleLabel];
    
    UILabel *accountInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(ACCOUNT_INFO_LABEL_X,
                                                                          ACCOUNT_INFO_LABEL_Y * SCREEN_HEIGHT,
                                                                          ACCOUNT_INFO_LABEL_W,
                                                                          ACCOUNT_INFO_LABEL_H * SCREEN_HEIGHT)];
    accountInfoLabel.text = @"Your account info";
    accountInfoLabel.font = [UIFont systemFontOfSize:18.0];
    [scrollView addSubview:accountInfoLabel];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(TIP_LABEL_X, TIP_LABEL_Y * SCREEN_HEIGHT, TIP_LABEL_W, TIP_LABEL_H * SCREEN_HEIGHT)];
    tipLabel.numberOfLines = 3;
    tipLabel.textAlignment = UITextAlignmentCenter;
    tipLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    tipLabel.layer.borderWidth = 2.0;
    tipLabel.text = @"Next, check your email and \n verify your account, then \n you're ready to play!";
    tipLabel.font = [UIFont systemFontOfSize:17.0];
    [scrollView addSubview:tipLabel];
}

- (void)signUpButtonClick
{
    [self endEditing];
    
    VSFSignUpEntity *entity = [[VSFSignUpEntity alloc] init];
    entity.email = emailText.text;
    entity.password = passwordText.text;
    entity.confirmPassword = confirmPasswordText.text;
    entity.firstname = firstnameText.text;
    entity.lastname = lastnameText.text;
    
    NSString *validateResult = [VSFUtility validateSignUpInfo:entity];
    if ([validateResult isEqualToString:@"SUCCESS"]) {
        NSLog(@"Sign Up Validate Success.");
        
        if ([VSFUtility checkNetwork]) {
            entity.password = [VSFUtility encrypt:passwordText.text];
            [process signUp:entity];
        }
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:validateResult delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)clickOnBackButton
{
    [self dismissModalViewControllerAnimated:YES];
    [self endEditing];
}

- (void)endEditing {
    CGRect frame = scrollView.frame;
    frame.origin.y = 0;
    frame.origin.x = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    [scrollView setScrollEnabled:NO];
    
    [emailText resignFirstResponder];
    [passwordText resignFirstResponder];
    [confirmPasswordText resignFirstResponder];
    [firstnameText resignFirstResponder];
    [lastnameText resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    [scrollView setScrollEnabled:YES];
    float moveY = 200;
    CGRect frame = scrollView.frame;
    frame.origin.y += moveY;
    frame.origin.x = 0;
    
    [scrollView scrollRectToVisible:frame animated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setScrollEnabled:NO];
    [self endEditing];
    return YES;
}


#pragma mark - SignUpProcessDelegate

- (void)setSignUpResult:(VSFResponseEntity *)respEntity
{
    if ([respEntity.success isEqualToString:@"false"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:respEntity.message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        
        [Flurry logEvent:@"SIGN_UP_FAILED"];
    } else if ([respEntity.success isEqualToString:@"true"]) {
        NSLog(@"sign up success");
        [self.delegate setSignUpSuccessFlag];
        [self dismissModalViewControllerAnimated:YES];
        [Flurry logEvent:@"SIGN_UP_SUCCESS"];
    }
}

@end
