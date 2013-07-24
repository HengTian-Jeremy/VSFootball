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
#import "VSFResponseEntity.h"

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
{
    int prewTag;
    float prewMoveY;
}

@property (nonatomic, retain) VSFSignUpProcess *process;
@property (nonatomic, retain) UILabel *emailLabel;
@property (nonatomic, retain) UILabel *passwordLabel;
@property (nonatomic, retain) UILabel *firstnameLabel;
@property (nonatomic, retain) UILabel *lastnameLabel;
@property (nonatomic, retain) UITextField *emailText;
@property (nonatomic, retain) UITextField *passwordText;
@property (nonatomic, retain) UITextField *firstnameText;
@property (nonatomic, retain) UITextField *lastnameText;
@property (nonatomic, retain) UIButton *signUpButton;

- (void)initUI;
- (void)signUpButtonClick;

@end

@implementation VSFSignUpViewController

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
        _process = [[VSFSignUpProcess alloc] init];
        self.process.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [_process release];
    [_emailLabel release];
    [_passwordLabel release];
    [_firstnameLabel release];
    [_lastnameLabel release];
    [_emailText release];
    [_passwordText release];
    [_firstnameText release];
    [_lastnameText release];
    [_signUpButton release];
    [super dealloc];
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
    [self.emailText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    [self.firstnameText resignFirstResponder];
    [self.lastnameText resignFirstResponder];
}

#pragma mark - Private Methods

- (void)initUI
{
    _emailLabel = [[UILabel alloc] init];
    self.emailLabel.frame = CGRectMake(EMAILLABEL_X, EMAILLABEL_Y, EMAILLABEL_W, EMAILLABEL_H);
    self.emailLabel.text = @"Email:";
    [self.view addSubview:self.emailLabel];
    
    _passwordLabel = [[UILabel alloc] init];
    self.passwordLabel.frame = CGRectMake(PASSWORDLABEL_X, PASSWORDLABEL_Y, PASSWORDLABEL_W, PASSWORDLABEL_H);
    self.passwordLabel.text = @"Password:";
    [self.view addSubview:self.passwordLabel];
    
    _firstnameLabel = [[UILabel alloc] init];
    self.firstnameLabel.frame = CGRectMake(FIRSTNAMELABEL_X, FIRSTNAMELABEL_Y, FIRSTNAMELLABEL_W, FIRSTNAMELABEL_H);
    self.firstnameLabel.text = @"Firstname:";
    [self.view addSubview:self.firstnameLabel];
    
    _lastnameLabel = [[UILabel alloc] init];
    self.lastnameLabel.frame = CGRectMake(LASTNAMELABEL_X, LASTNAMELABEL_Y, LASTNAMELABEL_W, LASTNAMELABEL_H);
    self.lastnameLabel.text = @"Lastname:";
    [self.view addSubview:self.lastnameLabel];
    
    _emailText = [[UITextField alloc] init];
    self.emailText.frame = CGRectMake(EMAILTEXT_X, EMAILTEXT_Y, EMAILTEXT_W, EMAILTEXT_H);
    self.emailText.borderStyle = UITextBorderStyleRoundedRect;
    self.emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.emailText];
    
    _passwordText = [[UITextField alloc] init];
    self.passwordText.frame = CGRectMake(PASSWORDTEXT_X, PASSWORDTEXT_Y, PASSWORDTEXT_W, PASSWORDTEXT_H);
    self.passwordText.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordText.secureTextEntry = YES;
    [self.view addSubview:self.passwordText];
    
    _firstnameText = [[UITextField alloc] init];
    self.firstnameText.frame = CGRectMake(FIRSTNAMETEXT_X, FIRSTNAMETEXT_Y, FIRSTNAMETEXT_W, FIRSTNAMETEXT_H);
    self.firstnameText.borderStyle = UITextBorderStyleRoundedRect;
    self.firstnameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.firstnameText];
    
    _lastnameText = [[UITextField alloc] init];
    self.lastnameText.frame = CGRectMake(LASTNAMETEXT_X, LASTNAMETEXT_Y, LASTNAMETEXT_W, LASTNAMETEXT_H);
    self.lastnameText.borderStyle = UITextBorderStyleRoundedRect;
    self.lastnameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.lastnameText.delegate = self;  // lastnameText will be covered by keyboard when writting
    [self.view addSubview:self.lastnameText];
    
    _signUpButton = [[UIButton alloc] init];
    self.signUpButton.frame = CGRectMake(SIGNUPBUTTON_X, SIGNUPBUTTON_Y, SIGNUPBUTTON_W, SIGNUPBUTTON_H);
    self.signUpButton.backgroundColor = [UIColor grayColor];
    [self.signUpButton setTitle:@"Sign UP" forState:UIControlStateNormal];
    [self.signUpButton addTarget:self action:@selector(signUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpButton];
}

- (void)signUpButtonClick
{
    [self.emailText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    [self.firstnameText resignFirstResponder];
    [self.lastnameText resignFirstResponder];
    
    VSFSignUpEntity *entity = [[VSFSignUpEntity alloc] init];
    entity.email = self.emailText.text;
    entity.password = self.passwordText.text;
    entity.firstname = self.firstnameText.text;
    entity.lastname = self.lastnameText.text;
    
    NSString *validateResult = [VSFUtility validateSignUpInfo:entity];
    if ([validateResult isEqualToString:@"SUCCESS"]) {
        NSLog(@"Sign Up Validate Success.");
        
        if ([VSFUtility checkNetwork]) {
            entity.password = [VSFUtility encrypt:self.passwordText.text];
            [self.process signUp:entity];
            [entity release];
        }
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:validateResult delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
}

#pragma mark UITextFieldDelegate

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
        [alertView release];
    } else {
        NSLog(@"sign up success");
    }
}

@end
