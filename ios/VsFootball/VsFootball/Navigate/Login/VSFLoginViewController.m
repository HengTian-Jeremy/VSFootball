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
#define USERNAMETEXT_X 144
#define USERNAMETEXT_Y 39
#define USERNAMETEXT_W 129
#define USERNAMETEXT_H 30
#define PASSWORDTEXT_X 144
#define PASSWORDTEXT_Y 94
#define PASSWORDTEXT_W 129
#define PASSWORDTEXT_H 30
#define LOGINBUTTON_X 226
#define LOGINBUTTON_Y 152
#define LOGINBUTTON_W 74
#define LOGINBUTTON_H 44
#define SIGNUPBUTTON_X 126
#define SIGNUPBUTTON_Y 162
#define SIGNUPBUTTON_W 74
#define SIGNUPBUTTON_H 34
#define RESENDEMAILBUTTON_X 6
#define RESENDEMAILBUTTON_Y 220
#define RESENDEMAILBUTTON_W 130
#define RESENDEMAILBUTTON_H 34
#define FORGOTPASSWORDBUTTON_X 146
#define FORGOTPASSWORDBUTTON_Y 210
#define FORGOTPASSWORDBUTTON_W 150
#define FORGOTPASSWORDBUTTON_H 44
#define DECKVIEW_LEFTSIZE 120

@interface VSFLoginViewController ()

- (void)initUI;
- (void)loginButtonClick;
- (void)signUpButtonClick;
- (void)resendEmailButtonClick;
- (void)forgotPasswordButtonClick;

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
    self.navigationController.navigationBarHidden = YES;
    
    usernameLabel = [[UILabel alloc] init];
    usernameLabel.frame = CGRectMake(USERNAMELABEL_X, USERNAMELABEL_Y, USERNAMELABEL_W, USERNAMELABEL_H);
    usernameLabel.text = @"Username:";
    [self.view addSubview:usernameLabel];
    
    passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(PASSWORDLABEL_X, PASSWORDLABEL_Y, PASSWORDLABEL_W, PASSWORDLABEL_H);
    passwordLabel.text = @"Password:";
    [self.view addSubview:passwordLabel];
    
    usernameText = [[UITextField alloc] init];
    usernameText.frame = CGRectMake(USERNAMETEXT_X, USERNAMETEXT_Y, USERNAMETEXT_W, USERNAMETEXT_H);
    usernameText.borderStyle = UITextBorderStyleRoundedRect;
    usernameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:usernameText];
    
    passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(PASSWORDTEXT_X, PASSWORDTEXT_Y, PASSWORDTEXT_W, PASSWORDTEXT_H);
    passwordText.borderStyle = UITextBorderStyleRoundedRect;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordText.secureTextEntry = YES;
    [self.view addSubview:passwordText];
    
    loginButton = [[UIButton alloc] init];
    loginButton.frame = CGRectMake(LOGINBUTTON_X, LOGINBUTTON_Y, LOGINBUTTON_W, LOGINBUTTON_H);
    loginButton.backgroundColor = [UIColor grayColor];
    [loginButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    signUpButton = [[UIButton alloc] init];
    signUpButton.frame = CGRectMake(SIGNUPBUTTON_X, SIGNUPBUTTON_Y, SIGNUPBUTTON_W, SIGNUPBUTTON_H);
    signUpButton.backgroundColor = [UIColor lightGrayColor];
    [signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(signUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    resendEmailButton = [[UIButton alloc] init];
    resendEmailButton.frame = CGRectMake(RESENDEMAILBUTTON_X, RESENDEMAILBUTTON_Y, RESENDEMAILBUTTON_W, RESENDEMAILBUTTON_H);
    resendEmailButton.backgroundColor = [UIColor lightGrayColor];
    [resendEmailButton setTitle:@"Re-Send Email" forState:UIControlStateNormal];
    [resendEmailButton addTarget:self action:@selector(resendEmailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resendEmailButton];
    
    forgotPasswordButton = [[UIButton alloc] init];
    forgotPasswordButton.frame = CGRectMake(FORGOTPASSWORDBUTTON_X, FORGOTPASSWORDBUTTON_Y, FORGOTPASSWORDBUTTON_W, FORGOTPASSWORDBUTTON_H);
    forgotPasswordButton.backgroundColor = [UIColor lightGrayColor];
    [forgotPasswordButton setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPasswordButton];
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
        [alertView addButtonWithTitle:@"Ok"];
        [alertView show];
    }
}

- (void)signUpButtonClick
{
    [self presentViewController:signUpVC animated:NO completion:nil];
}

-(void)resendEmailButtonClick
{
    NSLog(@"resendEmailButtonClick method");
}

- (void)forgotPasswordButtonClick
{
   NSLog(@"forgotPasswordButtonClick method");
}

#pragma mark - LoginProcessDelegate

- (void)setLoginResult:(VSFResponseEntity *)respEntity
{
    if ([respEntity.success isEqualToString:@"false"]) {
        [alertView setTitle:@"Notice"];
        if ([respEntity.message isEqualToString:@"Account has not been verified"]) {
            [alertView setMessage:[NSString stringWithFormat:@"%@, please re-send email again.", respEntity.message]];
        } else {
            [alertView setMessage:respEntity.message];
        }
        [alertView addButtonWithTitle:@"Ok"];
        [alertView show];
    } else {
        NSLog(@"sign in success");
        VSFHomeViewController *homeViewController = [[VSFHomeViewController alloc] init];
        VSFPlaybookViewController *playbookViewController = [[VSFPlaybookViewController alloc] init];
        IIViewDeckController *deckViewController = [[IIViewDeckController alloc] initWithCenterViewController:homeViewController leftViewController:playbookViewController];
        deckViewController.leftSize =  DECKVIEW_LEFTSIZE;
        [self presentViewController:deckViewController animated:YES completion:nil];
    }
}

- (void)setResendEmailNotificationResult:(VSFResendEmailNotificationResponseEntity *)respEntity
{
    [alertView setTitle:@"Notice"];
    [alertView setMessage:respEntity.message];
    [alertView addButtonWithTitle:@"Ok"];
    [alertView show];
}

- (void)setForgotPasswordResult:(VSFResponseEntity *)respEntity
{
    [alertView setTitle:@"Notice"];
    [alertView setMessage:respEntity.message];
    [alertView addButtonWithTitle:@"Ok"];
    [alertView show];
}

#pragma mark - VSFSignUpViewControllerDelegate

- (void)setSignUpSuccessFlag
{
    [alertView setTitle:@"Notice"];
    [alertView setMessage:@"Sign Up successfully! Before login, you should verify email first."];
    [alertView addButtonWithTitle:@"Ok"];
    [alertView show];
}

@end
