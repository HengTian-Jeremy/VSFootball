//
//  VSFLoginViewController.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFLoginViewController.h"

#import "VSFResponseEntity.h"
#import "VSFUtility.h"
#import "VSFSignUpViewController.h"
#import "VSFUserDataManagement.h"

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
#define FORGOTPASSWORDBUTTON_X 126
#define FORGOTPASSWORDBUTTON_Y 210
#define FORGOTPASSWORDBUTTON_W 150
#define FORGOTPASSWORDBUTTON_H 44

@interface VSFLoginViewController ()
{
    VSFLoginProcess *process;
    VSFForgotPasswordProcess *forgotPasswordProcess;
    
    UILabel *usernameLabel;
    UILabel *passwordLabel;
    UITextField *usernameText;
    UITextField *passwordText;
    UIButton *loginButton;
    
    UIButton *signUpButton;
    
    UIButton *forgotPasswordButton;
}

- (void)initUI;
- (void)loginButtonClick;
- (void)signUpButtonClick;

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
        
        forgotPasswordProcess = [[VSFForgotPasswordProcess alloc] init];
        forgotPasswordProcess.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [forgotPasswordProcess release];
    [process release];
    [usernameLabel release];
    [passwordLabel release];
    [usernameText release];
    [passwordText release];
    [loginButton release];
    [signUpButton release];
    [forgotPasswordButton release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    
    forgotPasswordButton = [[UIButton alloc] init];
    forgotPasswordButton.frame = CGRectMake(FORGOTPASSWORDBUTTON_X, FORGOTPASSWORDBUTTON_Y, FORGOTPASSWORDBUTTON_W, FORGOTPASSWORDBUTTON_H);
    forgotPasswordButton.backgroundColor = [UIColor lightGrayColor];
    [forgotPasswordButton setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPasswordButton];
}

#pragma mark - action
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
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:validateResult delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
}

- (void)signUpButtonClick
{
    VSFSignUpViewController *signUpVC = [[VSFSignUpViewController alloc] init];
    [self.navigationController pushViewController:signUpVC animated:YES];
    [signUpVC release];
}

- (void)forgotPasswordButtonClick
{
    if ([VSFUtility checkNetwork]) {
        [forgotPasswordProcess forgotPassword:[VSFUserDataManagement readEmail]];
    }
}

#pragma mark - LoginProcessDelegate

- (void)setLoginResult:(VSFResponseEntity *)respEntity
{
    if ([respEntity.success isEqualToString:@"false"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:respEntity.message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    } else {
        NSLog(@"sign in success");
    }
}

#pragma mark - ForgotPasswordProcessDelegate
- (void)setForgotPasswordResult:(VSFResponseEntity *)respEntity
{
    if ([respEntity.success isEqualToString:@"false"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:respEntity.message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }else {
        NSLog(@"password has been sent");
    }
}

@end
