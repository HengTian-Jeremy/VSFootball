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
#import "VSFUserDataManagement.h"
#import "VSFLoginViewController.h"

#define EMAILLABEL_X 58
#define EMAILLABEL_Y 24
#define EMAILLABEL_W 48
#define EMAILLABEL_H 21
#define PASSWORDLABEL_X 26
#define PASSWORDLABEL_Y 87
#define PASSWORDLABEL_W 80
#define PASSWORDLABEL_H 21
#define FIRSTNAMELABEL_X 20
#define FIRSTNAMELABEL_Y 147
#define FIRSTNAMELLABEL_W 86
#define FIRSTNAMELABEL_H 21
#define LASTNAMELABEL_X 23
#define LASTNAMELABEL_Y 210
#define LASTNAMELABEL_W 83
#define LASTNAMELABEL_H 21
#define EMAILTEXT_X 114
#define EMAILTEXT_Y 20
#define EMAILTEXT_W 164
#define EMAILTEXT_H 30
#define PASSWORDTEXT_X 114
#define PASSWORDTEXT_Y 78
#define PASSWORDTEXT_W 164
#define PASSWORDTEXT_H 30
#define FIRSTNAMETEXT_X 114
#define FIRSTNAMETEXT_Y 138
#define FIRSTNAMETEXT_W 164
#define FIRSTNAMETEXT_H 30
#define LASTNAMETEXT_X 114
#define LASTNAMETEXT_Y 201
#define LASTNAMETEXT_W 164
#define LASTNAMETEXT_H 30
#define SIGNUPBUTTON_X 219
#define SIGNUPBUTTON_Y 261
#define SIGNUPBUTTON_W 81
#define SIGNUPBUTTON_H 44

@interface VSFSignUpViewController ()

- (void)initUI;
- (void)signUpButtonClick;

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
    [firstnameText resignFirstResponder];
    [lastnameText resignFirstResponder];
}

#pragma mark - Private Methods

- (void)initUI
{
    emailLabel = [[UILabel alloc] init];
    emailLabel.frame = CGRectMake(EMAILLABEL_X, EMAILLABEL_Y, EMAILLABEL_W, EMAILLABEL_H);
    emailLabel.text = @"Email:";
    [self.view addSubview:emailLabel];
    
    passwordLabel = [[UILabel alloc] init];
    passwordLabel.frame = CGRectMake(PASSWORDLABEL_X, PASSWORDLABEL_Y, PASSWORDLABEL_W, PASSWORDLABEL_H);
    passwordLabel.text = @"Password:";
    [self.view addSubview:passwordLabel];
    
    firstnameLabel = [[UILabel alloc] init];
    firstnameLabel.frame = CGRectMake(FIRSTNAMELABEL_X, FIRSTNAMELABEL_Y, FIRSTNAMELLABEL_W, FIRSTNAMELABEL_H);
    firstnameLabel.text = @"Firstname:";
    [self.view addSubview:firstnameLabel];
    
    lastnameLabel = [[UILabel alloc] init];
    lastnameLabel.frame = CGRectMake(LASTNAMELABEL_X, LASTNAMELABEL_Y, LASTNAMELABEL_W, LASTNAMELABEL_H);
    lastnameLabel.text = @"Lastname:";
    [self.view addSubview:lastnameLabel];
    
    emailText = [[UITextField alloc] init];
    emailText.frame = CGRectMake(EMAILTEXT_X, EMAILTEXT_Y, EMAILTEXT_W, EMAILTEXT_H);
    emailText.borderStyle = UITextBorderStyleRoundedRect;
    emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:emailText];
    
    passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(PASSWORDTEXT_X, PASSWORDTEXT_Y, PASSWORDTEXT_W, PASSWORDTEXT_H);
    passwordText.borderStyle = UITextBorderStyleRoundedRect;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordText.secureTextEntry = YES;
    [self.view addSubview:passwordText];
    
    firstnameText = [[UITextField alloc] init];
    firstnameText.frame = CGRectMake(FIRSTNAMETEXT_X, FIRSTNAMETEXT_Y, FIRSTNAMETEXT_W, FIRSTNAMETEXT_H);
    firstnameText.borderStyle = UITextBorderStyleRoundedRect;
    firstnameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:firstnameText];
    
    lastnameText = [[UITextField alloc] init];
    lastnameText.frame = CGRectMake(LASTNAMETEXT_X, LASTNAMETEXT_Y, LASTNAMETEXT_W, LASTNAMETEXT_H);
    lastnameText.borderStyle = UITextBorderStyleRoundedRect;
    lastnameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastnameText.delegate = self;  // lastnameText will be covered by keyboard when writting
    [self.view addSubview:lastnameText];
    
    signUpButton = [[UIButton alloc] init];
    signUpButton.frame = CGRectMake(SIGNUPBUTTON_X, SIGNUPBUTTON_Y, SIGNUPBUTTON_W, SIGNUPBUTTON_H);
    signUpButton.backgroundColor = [UIColor grayColor];
    [signUpButton setTitle:@"Sign UP" forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(signUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
}

- (void)signUpButtonClick
{
    [emailText resignFirstResponder];
    [passwordText resignFirstResponder];
    [firstnameText resignFirstResponder];
    [lastnameText resignFirstResponder];
    
    VSFSignUpEntity *entity = [[VSFSignUpEntity alloc] init];
    entity.email = emailText.text;
    entity.password = passwordText.text;
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
    } else {
        NSLog(@"sign up success");
        VSFLoginViewController *loginVC = [[VSFLoginViewController alloc] init];
        [self.delegate setSignUpSuccessFlag];
        [self presentViewController:loginVC animated:NO completion:nil];
//        [VSFUserDataManagement saveUserEmail:[emailText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
}

@end
