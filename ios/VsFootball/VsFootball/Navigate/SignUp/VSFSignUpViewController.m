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

// Email Label
#define EMAILLABEL_X 10
#define EMAILLABEL_Y 0.05
#define EMAILLABEL_W 90
#define EMAILLABEL_H 0.06
// Password Label
#define PASSWORDLABEL_X 10
#define PASSWORDLABEL_Y 0.15
#define PASSWORDLABEL_W 90
#define PASSWORDLABEL_H 0.06
// Confirm Password Label
#define CONFIRMPASSWORDLABEL_X 10
#define CONFIRMPASSWORDLABEL_Y 0.25
#define CONFIRMPASSWORDLABEL_W 90
#define CONFIRMPASSWORDLABEL_H 0.06
// Firstname Label
#define FIRSTNAMELABEL_X 10
#define FIRSTNAMELABEL_Y 0.35
#define FIRSTNAMELLABEL_W 90
#define FIRSTNAMELABEL_H 0.06
// Lastname Label
#define LASTNAMELABEL_X 10
#define LASTNAMELABEL_Y 0.45
#define LASTNAMELABEL_W 90
#define LASTNAMELABEL_H 0.06
// Email TextField
#define EMAILTEXT_X 115
#define EMAILTEXT_Y 0.05
#define EMAILTEXT_W 165
#define EMAILTEXT_H 0.06
// Password TextField
#define PASSWORDTEXT_X 115
#define PASSWORDTEXT_Y 0.15
#define PASSWORDTEXT_W 165
#define PASSWORDTEXT_H 0.06
// Confirm Password TextField
#define CONFIRMPASSWORDTEXT_X 115
#define CONFIRMPASSWORDTEXT_Y 0.25
#define CONFIRMPASSWORDTEXT_W 165
#define CONFIRMPASSWORDTEXT_H 0.06
// Firstname TextField
#define FIRSTNAMETEXT_X 115
#define FIRSTNAMETEXT_Y 0.35
#define FIRSTNAMETEXT_W 165
#define FIRSTNAMETEXT_H 0.06
// Lastname TextField
#define LASTNAMETEXT_X 115
#define LASTNAMETEXT_Y 0.45
#define LASTNAMETEXT_W 165
#define LASTNAMETEXT_H 0.06
// Sign Up button
#define SIGNUPBUTTON_X 219
#define SIGNUPBUTTON_Y 261
#define SIGNUPBUTTON_W 81
#define SIGNUPBUTTON_H 32
// Go back button
#define BACKBUTTON_X 80
#define BACKBUTTON_Y 261
#define BACKBUTTON_W 80
#define BACKBUTTON_H 32

@interface VSFSignUpViewController ()

- (void)initUI;
- (void)signUpButtonClick;
- (void)clickOnBackButton;

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [emailText resignFirstResponder];
    [passwordText resignFirstResponder];
    [confirmPasswordText resignFirstResponder];
    [firstnameText resignFirstResponder];
    [lastnameText resignFirstResponder];
}

#pragma mark - Private Methods

- (void)initUI
{
    emailLabel = [[UILabel alloc] init];
    emailLabel.frame = CGRectMake(EMAILLABEL_X, EMAILLABEL_Y * SCREEN_HEIGHT, EMAILLABEL_W, EMAILLABEL_H * SCREEN_HEIGHT);
    emailLabel.text = @"Email:";
    emailLabel.textAlignment = UITextAlignmentRight;
    emailLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:emailLabel];
    
    passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(PASSWORDLABEL_X, PASSWORDLABEL_Y * SCREEN_HEIGHT, PASSWORDLABEL_W, PASSWORDLABEL_H * SCREEN_HEIGHT);
    passwordLabel.text = @"Password:";
    passwordLabel.textAlignment = UITextAlignmentRight;
    passwordLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:passwordLabel];
    
    confirmPasswordLabel = [[UILabel alloc] init];
    confirmPasswordLabel.frame = CGRectMake(CONFIRMPASSWORDLABEL_X, CONFIRMPASSWORDLABEL_Y * SCREEN_HEIGHT, CONFIRMPASSWORDLABEL_W, CONFIRMPASSWORDLABEL_H * SCREEN_HEIGHT);
    confirmPasswordLabel.text = @"Confirm Password:";
    confirmPasswordLabel.textAlignment = UITextAlignmentRight;
    confirmPasswordLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:confirmPasswordLabel];
    
    firstnameLabel = [[UILabel alloc] init];
    firstnameLabel.frame = CGRectMake(FIRSTNAMELABEL_X, FIRSTNAMELABEL_Y * SCREEN_HEIGHT, FIRSTNAMELLABEL_W, FIRSTNAMELABEL_H * SCREEN_HEIGHT);
    firstnameLabel.text = @"First Name:";
    firstnameLabel.textAlignment = UITextAlignmentRight;
    firstnameLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:firstnameLabel];
    
    lastnameLabel = [[UILabel alloc] init];
    lastnameLabel.frame = CGRectMake(LASTNAMELABEL_X, LASTNAMELABEL_Y * SCREEN_HEIGHT, LASTNAMELABEL_W, LASTNAMELABEL_H * SCREEN_HEIGHT);
    lastnameLabel.text = @"Last Name:";
    lastnameLabel.textAlignment = UITextAlignmentRight;
    lastnameLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:lastnameLabel];
    
    emailText = [[UITextField alloc] init];
    emailText.frame = CGRectMake(EMAILTEXT_X, EMAILTEXT_Y * SCREEN_HEIGHT, EMAILTEXT_W, EMAILTEXT_H * SCREEN_HEIGHT);
    emailText.borderStyle = UITextBorderStyleRoundedRect;
    emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:emailText];
    
    passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(PASSWORDTEXT_X, PASSWORDTEXT_Y * SCREEN_HEIGHT, PASSWORDTEXT_W, PASSWORDTEXT_H * SCREEN_HEIGHT);
    passwordText.borderStyle = UITextBorderStyleRoundedRect;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordText.secureTextEntry = YES;
    [self.view addSubview:passwordText];
    
    confirmPasswordText = [[UITextField alloc] init];
    confirmPasswordText.frame = CGRectMake(CONFIRMPASSWORDTEXT_X, CONFIRMPASSWORDTEXT_Y * SCREEN_HEIGHT, CONFIRMPASSWORDTEXT_W, CONFIRMPASSWORDTEXT_H * SCREEN_HEIGHT);
    confirmPasswordText.borderStyle = UITextBorderStyleRoundedRect;
    confirmPasswordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmPasswordText.secureTextEntry = YES;
    [self.view addSubview:confirmPasswordText];
    
    firstnameText = [[UITextField alloc] init];
    firstnameText.frame = CGRectMake(FIRSTNAMETEXT_X, FIRSTNAMETEXT_Y * SCREEN_HEIGHT, FIRSTNAMETEXT_W, FIRSTNAMETEXT_H * SCREEN_HEIGHT);
    firstnameText.borderStyle = UITextBorderStyleRoundedRect;
    firstnameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:firstnameText];
    
    lastnameText = [[UITextField alloc] init];
    lastnameText.frame = CGRectMake(LASTNAMETEXT_X, LASTNAMETEXT_Y * SCREEN_HEIGHT, LASTNAMETEXT_W, LASTNAMETEXT_H * SCREEN_HEIGHT);
    lastnameText.borderStyle = UITextBorderStyleRoundedRect;
    lastnameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastnameText.delegate = self;  // lastnameText will be covered by keyboard when writting
    [self.view addSubview:lastnameText];
    
    signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    signUpButton.frame = CGRectMake(SIGNUPBUTTON_X, SIGNUPBUTTON_Y, SIGNUPBUTTON_W, SIGNUPBUTTON_H);
    [signUpButton setTitle:@"Join us" forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(signUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    UIButton *goBackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goBackButton.frame = CGRectMake(BACKBUTTON_X, BACKBUTTON_Y, BACKBUTTON_W, BACKBUTTON_H);
    [goBackButton setTitle:@"Back" forState:UIControlStateNormal];
    [goBackButton addTarget:self action:@selector(clickOnBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBackButton];

}

- (void)signUpButtonClick
{
    [emailText resignFirstResponder];
    [passwordText resignFirstResponder];
    [confirmPasswordText resignFirstResponder];
    [firstnameText resignFirstResponder];
    [lastnameText resignFirstResponder];
    
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
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFrame = textField.frame;
    float textY = textFrame.origin.y + textFrame.size.height;
    float bottomY = self.view.frame.size.height - textY;
    if (bottomY >= 216) {   // 216 is default keyboard height
        prewTag = -1;
        return;
    }
    prewTag = textField.tag;
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
    if (prewTag == -1) {
        return;
    }
    float moveY;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    if (prewTag == textField.tag) {
        moveY =  prewMoveY;
        frame.origin.y += moveY;
        frame.size. height -= moveY;
        self.view.frame = frame;
    }
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    [textField resignFirstResponder];
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
        VSFLoginViewController *loginVC = [[VSFLoginViewController alloc] init];
        [self.delegate setSignUpSuccessFlag];
        [self dismissModalViewControllerAnimated:YES];
//        [VSFUserDataManagement saveUserEmail:[emailText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        [Flurry logEvent:@"SIGN_UP_SUCCESS"];
    }
}

@end
