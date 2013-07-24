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

@interface VSFLoginViewController ()

@property (nonatomic, retain) VSFLoginProcess *process;
@property (nonatomic, retain) UILabel *usernameLabel;
@property (nonatomic, retain) UILabel *passwordLabel;
@property (nonatomic, retain) UITextField *usernameText;
@property (nonatomic, retain) UITextField *passwordText;
@property (nonatomic, retain) UIButton *loginButton;

@property (nonatomic, retain) UIButton *signUpButton;

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
        _process = [[VSFLoginProcess alloc] init];
        self.process.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [_process release];
    [_usernameLabel release];
    [_passwordLabel release];
    [_usernameText release];
    [_passwordText release];
    [_loginButton release];
    [_signUpButton release];
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
    [self.usernameText resignFirstResponder];
    [self.passwordText resignFirstResponder];
}

#pragma mark - Private Methods

- (void)initUI
{
    _usernameLabel = [[UILabel alloc] init];
    self.usernameLabel.frame = CGRectMake(USERNAMELABEL_X, USERNAMELABEL_Y, USERNAMELABEL_W, USERNAMELABEL_H);
    self.usernameLabel.text = @"Username:";
    [self.view addSubview:self.usernameLabel];
    
    _passwordLabel = [[UILabel alloc] init];
    self.passwordLabel.frame = CGRectMake(PASSWORDLABEL_X, PASSWORDLABEL_Y, PASSWORDLABEL_W, PASSWORDLABEL_H);
    self.passwordLabel.text = @"Password:";
    [self.view addSubview:self.passwordLabel];
    
    _usernameText = [[UITextField alloc] init];
    self.usernameText.frame = CGRectMake(USERNAMETEXT_X, USERNAMETEXT_Y, USERNAMETEXT_W, USERNAMETEXT_H);
    self.usernameText.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.usernameText];
    
    _passwordText = [[UITextField alloc] init];
    self.passwordText.frame = CGRectMake(PASSWORDTEXT_X, PASSWORDTEXT_Y, PASSWORDTEXT_W, PASSWORDTEXT_H);
    self.passwordText.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordText.secureTextEntry = YES;
    [self.view addSubview:self.passwordText];
    
    _loginButton = [[UIButton alloc] init];
    self.loginButton.frame = CGRectMake(LOGINBUTTON_X, LOGINBUTTON_Y, LOGINBUTTON_W, LOGINBUTTON_H);
    self.loginButton.backgroundColor = [UIColor grayColor];
    [self.loginButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    _signUpButton = [[UIButton alloc] init];
    self.signUpButton.frame = CGRectMake(SIGNUPBUTTON_X, SIGNUPBUTTON_Y, SIGNUPBUTTON_W, SIGNUPBUTTON_H);
    self.signUpButton.backgroundColor = [UIColor lightGrayColor];
    [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signUpButton addTarget:self action:@selector(signUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpButton];
}

- (void)loginButtonClick
{
    [self.usernameText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    
    NSString *validateResult = [VSFUtility validateSignInInfo:self.usernameText.text withPassword:self.passwordText.text];
    if ([validateResult isEqualToString:@"SUCCESS"]) {
        NSLog(@"Validate Success.");
        
        if ([VSFUtility checkNetwork]) {
            NSString *encryptPassword = [VSFUtility encrypt:self.passwordText.text];
            [self.process login:self.usernameText.text withPassword:encryptPassword];
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

@end
