//
//  VSFLoginViewController.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFLoginViewController.h"

#import "VSFLoginResponseEntity.h"
#import "VSFResendEmailNotificationResponseEntity.h"
#import "VSFForgotPasswordResponseEntity.h"
#import "VSFUtility.h"
#import "VSFSignUpViewController.h"
#import "VSFHomeViewController.h"
#import "VSFPlaybookViewController.h"
#import "IIViewDeckController.h"

#define USERNAMELABEL_X 47
#define USERNAMELABEL_Y 48
#define USERNAMELABEL_W 84
#define USERNAMELABEL_H 21
#define PASSWORDLABEL_X 47
#define PASSWORDLABEL_Y 97
#define PASSWORDLABEL_W 80
#define PASSWORDLABEL_H 21
// Title Label
#define TITLE_LABEL_X 80
#define TITLE_LABEL_Y 30
#define TITLE_LABEL_W 160
#define TITLE_LABEL_H 30
// facebook button
#define FACEBOOK_BUTTON_X 50
#define FACEBOOK_BUTTON_Y 80
#define FACEBOOK_BUTTON_W 220
#define FACEBOOK_BUTTON_H 40
// Username TextField
#define USERNAMETEXT_X 80
#define USERNAMETEXT_Y 140
#define USERNAMETEXT_W 160
#define USERNAMETEXT_H 26
// Password TextField
#define PASSWORDTEXT_X 80
#define PASSWORDTEXT_Y 190
#define PASSWORDTEXT_W 160
#define PASSWORDTEXT_H 26
// Login Button
#define LOGINBUTTON_X 180
#define LOGINBUTTON_Y 226
#define LOGINBUTTON_W 60
#define LOGINBUTTON_H 30
// Sign up button
#define SIGNUPBUTTON_X 50
#define SIGNUPBUTTON_Y 270
#define SIGNUPBUTTON_W 220
#define SIGNUPBUTTON_H 28
// Resend email button
#define RESENDEMAILBUTTON_X 20
#define RESENDEMAILBUTTON_Y 320
#define RESENDEMAILBUTTON_W 120
#define RESENDEMAILBUTTON_H 30
// Forgot password button
#define FORGOTPASSWORDBUTTON_X 150
#define FORGOTPASSWORDBUTTON_Y 320
#define FORGOTPASSWORDBUTTON_W 150
#define FORGOTPASSWORDBUTTON_H 30
// Verification email view
#define VERIFICATION_EMAIL_VIEW_X 10
#define VERIFICATION_EMAIL_VIEW_Y 0.3
#define VERIFICATION_EMAIL_VIEW_W 280
#define VERIFICATION_EMAIL_VIEW_H 0.3

#define DECKVIEW_LEFTSIZE 120

@interface VSFLoginViewController ()

- (void)initUI;
- (void)loginButtonClick;
- (void)signUpButtonClick;
- (void)resendEmailButtonClick;
- (void)forgotPasswordButtonClick;
- (void)enterHomeView;
- (void)loginWithFacebook;

@end

@implementation VSFLoginViewController

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
        process = [[VSFLoginProcess alloc] init];
        process.delegate = self;
        
        signUpVC = [[VSFSignUpViewController alloc] init];
        signUpVC.delegate = self;
        
        alertView = [[UIAlertView alloc] init];
        alertView.delegate = self;
        [alertView addButtonWithTitle:@"Ok"];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [usernameText resignFirstResponder];
    [passwordText resignFirstResponder];
}

#pragma mark - Private Methods

- (void)initUI
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_W, TITLE_LABEL_H)];
    titleLabel.text = @"Vs.Football";
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:titleLabel];
    
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    facebookButton.frame = CGRectMake(FACEBOOK_BUTTON_X, FACEBOOK_BUTTON_Y, FACEBOOK_BUTTON_W, FACEBOOK_BUTTON_H);
    [facebookButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(loginWithFacebook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookButton];
    
    
    usernameLabel = [[UILabel alloc] init];
    usernameLabel.frame = CGRectMake(USERNAMELABEL_X, USERNAMELABEL_Y, USERNAMELABEL_W, USERNAMELABEL_H);
    usernameLabel.text = @"Username:";
    //    [self.view addSubview:usernameLabel];
    
    passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(PASSWORDLABEL_X, PASSWORDLABEL_Y, PASSWORDLABEL_W, PASSWORDLABEL_H);
    passwordLabel.text = @"Password:";
    //    [self.view addSubview:passwordLabel];
    
    usernameText = [[UITextField alloc] init];
    usernameText.frame = CGRectMake(USERNAMETEXT_X, USERNAMETEXT_Y, USERNAMETEXT_W, USERNAMETEXT_H);
    usernameText.borderStyle = UITextBorderStyleRoundedRect;
    usernameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameText.placeholder = @"Username";
    usernameText.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview:usernameText];
    
    passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(PASSWORDTEXT_X, PASSWORDTEXT_Y, PASSWORDTEXT_W, PASSWORDTEXT_H);
    passwordText.borderStyle = UITextBorderStyleRoundedRect;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordText.placeholder = @"Password";
    passwordText.keyboardType = UIKeyboardTypeEmailAddress;
    passwordText.secureTextEntry = YES;
    [self.view addSubview:passwordText];
    
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(LOGINBUTTON_X, LOGINBUTTON_Y, LOGINBUTTON_W, LOGINBUTTON_H);
    [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUpButton.frame = CGRectMake(SIGNUPBUTTON_X, SIGNUPBUTTON_Y, SIGNUPBUTTON_W, SIGNUPBUTTON_H);
    [signUpButton setTitle:@"Create a VS.Football signon" forState:UIControlStateNormal];
    signUpButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [signUpButton addTarget:self action:@selector(signUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    resendEmailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resendEmailButton.frame = CGRectMake(RESENDEMAILBUTTON_X, RESENDEMAILBUTTON_Y, RESENDEMAILBUTTON_W, RESENDEMAILBUTTON_H);
    [resendEmailButton setTitle:@"Re-Send Email" forState:UIControlStateNormal];
    [resendEmailButton addTarget:self action:@selector(resendEmailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resendEmailButton];
    
    forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    forgotPasswordButton.frame = CGRectMake(FORGOTPASSWORDBUTTON_X, FORGOTPASSWORDBUTTON_Y, FORGOTPASSWORDBUTTON_W, FORGOTPASSWORDBUTTON_H);
    [forgotPasswordButton setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPasswordButton];
}

- (void)loginWithFacebook
{
    
}

- (void)loginButtonClick
{
    [usernameText resignFirstResponder];
    [passwordText resignFirstResponder];
    
    NSString *validateResult = [VSFUtility validateSignInInfo:usernameText.text withPassword:passwordText.text];
    if ([validateResult isEqualToString:@"SUCCESS"]) {
        NSLog(@"Validate Success.");
        
        if ([VSFUtility checkNetwork]) {
            NSString *encryptPassword = [VSFUtility encrypt:passwordText.text];
            [process login:usernameText.text withPassword:encryptPassword];
        }
    } else {
        [alertView setTitle:@"Notice"];
        [alertView setMessage:validateResult];
        [alertView show];
    }
}

- (void)signUpButtonClick
{
    signUpVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController presentModalViewController:signUpVC animated:YES];
}

-(void)resendEmailButtonClick
{
    NSLog(@"resendEmailButtonClick method");
    //    [process resendEmailNotification:@"hanqunhu@hengtiansoft.com"];
    verifyEmailView = [[VSFVerifyEmailView alloc] initWithFrame:CGRectMake(VERIFICATION_EMAIL_VIEW_X, self.view.bounds.size.height * VERIFICATION_EMAIL_VIEW_Y, VERIFICATION_EMAIL_VIEW_W, self.view.bounds.size.height * VERIFICATION_EMAIL_VIEW_H)];
    verifyEmailView.delegate = self;
    verifyEmailView.type = @"ResendEmail";
    [verifyEmailView setTitle:@"Input your verification email"];
    [verifyEmailView show];
}

- (void)forgotPasswordButtonClick
{
    NSLog(@"forgotPasswordButtonClick method");
    verifyEmailView = [[VSFVerifyEmailView alloc] initWithFrame:CGRectMake(VERIFICATION_EMAIL_VIEW_X, self.view.bounds.size.height * VERIFICATION_EMAIL_VIEW_Y, VERIFICATION_EMAIL_VIEW_W, self.view.bounds.size.height * VERIFICATION_EMAIL_VIEW_H)];
    verifyEmailView.delegate = self;
    verifyEmailView.type = @"ForgotPassword";
    [verifyEmailView setTitle:@"Input your verification email"];
    [verifyEmailView show];
    
    //    [process forgotPassword:@"hanqunhu@hengtiansoft.com"];
}

- (void)enterHomeView
{
    VSFHomeViewController *homeViewController = [[VSFHomeViewController alloc] init];
    VSFPlaybookViewController *playbookViewController = [[VSFPlaybookViewController alloc] init];
    IIViewDeckController *deckViewController = [[IIViewDeckController alloc] initWithCenterViewController:homeViewController leftViewController:playbookViewController];
    deckViewController.leftSize = DECKVIEW_LEFTSIZE;
    //        [self presentViewController:deckViewController animated:YES completion:nil];
    [self.navigationController pushViewController:deckViewController animated:YES];
}

#pragma mark - LoginProcessDelegate

- (void)setLoginResult:(VSFLoginResponseEntity *)respEntity
{
    if ([respEntity.success isEqualToString:@"false"]) {
        [alertView setTitle:@"Notice"];
        if ([respEntity.message isEqualToString:@"Account has not been verified"]) {
            [alertView setMessage:[NSString stringWithFormat:@"%@, please re-send email again.", respEntity.message]];
        } else {
            [alertView setMessage:respEntity.message];
        }
        [alertView show];
        
        [Flurry logEvent:@"LOGIN_FAILED"];
    } else if ([respEntity.success isEqualToString:@"true"]) {
        NSLog(@"sign in success");
        [self enterHomeView];
        
        [Flurry logEvent:@"LOGIN_SUCCESS"];
    }
}

- (void)setResendEmailNotificationResult:(VSFResendEmailNotificationResponseEntity *)respEntity
{
    [alertView setTitle:@"Notice"];
    [alertView setMessage:respEntity.message];
    [alertView show];
    
    [Flurry logEvent:@"RESEND_EMAIL"];
}

- (void)setForgotPasswordResult:(VSFForgotPasswordResponseEntity *)respEntity
{
    [alertView setTitle:@"Notice"];
    [alertView setMessage:respEntity.message];
    [alertView show];
    
    [Flurry logEvent:@"FORGOT_PASSWORD"];
}

#pragma mark - VSFSignUpViewControllerDelegate

- (void)setSignUpSuccessFlag
{
    [alertView setTitle:@"Notice"];
    [alertView setMessage:@"Sign Up successfully! Before login, you should verify email first."];
    [alertView show];
}

#pragma mark - VSFVerifyEmailViewDelegate

- (void)sendEmailWhenForgotPassword:(NSString *)email
{
    [process forgotPassword:email];
}

- (void)resendEmail:(NSString *)email
{
    [process resendEmailNotification:email];
}

- (void)close
{
    [verifyEmailView dismiss];
}

@end
