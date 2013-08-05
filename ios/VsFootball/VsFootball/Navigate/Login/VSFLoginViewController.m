//
//  VSFLoginViewController.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFLoginViewController.h"

#import "VSFAppDelegate.h"
#import "DDMenuController.h"
#import "VSFLoginResponseEntity.h"
#import "VSFResendEmailNotificationResponseEntity.h"
#import "VSFUtility.h"
#import "VSFSignUpViewController.h"
#import "VSFHomeViewController.h"
#import "VSFPlaybookViewController.h"
#import "VSFADBannerView.h"
#import "VSFForgotPasswordViewController.h"
#import "VSFCommonDefine.h"

// Title Label
#define TITLE_LABEL_X 80
#define TITLE_LABEL_Y 0.0938
#define TITLE_LABEL_W 160
#define TITLE_LABEL_H 0.0625
// facebook button
#define FACEBOOK_BUTTON_X 60
#define FACEBOOK_BUTTON_Y 0.1979
#define FACEBOOK_BUTTON_W 200
#define FACEBOOK_BUTTON_H 0.0625
// facebook describe Label
#define FACEBOOKDESCRIBE_LABEL_X 30
#define FACEBOOKDESCRIBE_LABEL_Y 0.2750
#define FACEBOOKDESCRIBE_LABEL_W 230
#define FACEBOOKDESCRIBE_LABEL_H 0.1042
// Or label
#define OR_LABEL_X 150
#define OR_LABEL_Y 0.4167
#define OR_LABEL_W 20
#define OR_LABEL_H 0.0417
// Login describe Label
#define LOGINDESCRIBE_LABEL_X 45
#define LOGINDESCRIBE_LABEL_Y 0.4583
#define LOGINDESCRIBE_LABEL_W 230
#define LOGINDESCRIBE_LABEL_H 0.0417
// Username TextField
#define USERNAMETEXT_X 60
#define USERNAMETEXT_Y 0.5167
#define USERNAMETEXT_W 200
#define USERNAMETEXT_H 0.0625
// Password TextField
#define PASSWORDTEXT_X 60
#define PASSWORDTEXT_Y 0.5958
#define PASSWORDTEXT_W 200
#define PASSWORDTEXT_H 0.0625
// Remember Password Check Button
#define CHECKBUTTON_X 70
#define CHECKBUTTON_Y 0.6708
#define CHECKBUTTON_W 25
#define CHECKBUTTON_H 0.0521
// Remember Password Label
#define REMEMBERPASSWORD_LABEL_X 100
#define REMEMBERPASSWORD_LABEL_Y 0.6771
#define REMEMBERPASSWORD_LABEL_W 162
#define REMEMBERPASSWORD_LABEL_H 0.0417
// Forgot password button
#define FORGOTPASSWORDBUTTON_X 30
#define FORGOTPASSWORDBUTTON_Y 0.7708
#define FORGOTPASSWORDBUTTON_W 155
#define FORGOTPASSWORDBUTTON_H 0.0625
// Login Button
#define LOGINBUTTON_X 200
#define LOGINBUTTON_Y 0.7708
#define LOGINBUTTON_W 70
#define LOGINBUTTON_H 0.0625
// Sign up button
#define SIGNUPBUTTON_X 55
#define SIGNUPBUTTON_Y 0.8542
#define SIGNUPBUTTON_W 220
#define SIGNUPBUTTON_H 0.0625
// Resend email button
#define RESENDEMAILBUTTON_X 20
#define RESENDEMAILBUTTON_Y 0.6667
#define RESENDEMAILBUTTON_W 120
#define RESENDEMAILBUTTON_H 0.0625
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
- (void)rememberPasswordCheckButtonClick;

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y * SCREEN_HEIGHT, TITLE_LABEL_W, TITLE_LABEL_H * SCREEN_HEIGHT)];
    titleLabel.text = @"Vs.Football";
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:30.0];
    [self.view addSubview:titleLabel];
    
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    facebookButton.frame = CGRectMake(FACEBOOK_BUTTON_X, FACEBOOK_BUTTON_Y * SCREEN_HEIGHT, FACEBOOK_BUTTON_W, FACEBOOK_BUTTON_H * SCREEN_HEIGHT);
    [facebookButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(loginWithFacebook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookButton];
    
    UILabel *facebookdescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(FACEBOOKDESCRIBE_LABEL_X,FACEBOOKDESCRIBE_LABEL_Y * SCREEN_HEIGHT,FACEBOOKDESCRIBE_LABEL_W,FACEBOOKDESCRIBE_LABEL_H * SCREEN_HEIGHT)];
    facebookdescribeLabel.text = @"Use Facebook signin to chanllenge your friends today!";
    facebookdescribeLabel.textAlignment = UITextAlignmentCenter;
    facebookdescribeLabel.font = [UIFont systemFontOfSize:17.0];
    facebookdescribeLabel.numberOfLines = 2;
    [self.view addSubview:facebookdescribeLabel];
    
    UILabel *orLabel = [[UILabel alloc] initWithFrame:CGRectMake(OR_LABEL_X, OR_LABEL_Y * SCREEN_HEIGHT, OR_LABEL_W, OR_LABEL_H * SCREEN_HEIGHT)];
    orLabel.text = @"Or";
    orLabel.textAlignment = UITextAlignmentCenter;
    orLabel.font =  [UIFont systemFontOfSize:17.0];
    [self.view addSubview:orLabel];
    
    UILabel *logindescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(LOGINDESCRIBE_LABEL_X, LOGINDESCRIBE_LABEL_Y * SCREEN_HEIGHT, LOGINDESCRIBE_LABEL_W, LOGINDESCRIBE_LABEL_H * SCREEN_HEIGHT)];
    logindescribeLabel.text = @"Login with Vs. Football signon";
    logindescribeLabel.textAlignment = UITextAlignmentCenter;
    logindescribeLabel.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:logindescribeLabel];
    
    usernameText = [[UITextField alloc] init];
    usernameText.frame = CGRectMake(USERNAMETEXT_X, USERNAMETEXT_Y * SCREEN_HEIGHT, USERNAMETEXT_W, USERNAMETEXT_H * SCREEN_HEIGHT);
    usernameText.borderStyle = UITextBorderStyleRoundedRect;
    usernameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameText.placeholder = @"Username";
    usernameText.keyboardType = UIKeyboardTypeEmailAddress;
    usernameText.delegate = self;
    [self.view addSubview:usernameText];
    
    passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(PASSWORDTEXT_X, PASSWORDTEXT_Y * SCREEN_HEIGHT, PASSWORDTEXT_W, PASSWORDTEXT_H * SCREEN_HEIGHT);
    passwordText.borderStyle = UITextBorderStyleRoundedRect;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordText.placeholder = @"Password";
    passwordText.keyboardType = UIKeyboardTypeEmailAddress;
    passwordText.secureTextEntry = YES;
    passwordText.delegate = self;
    [self.view addSubview:passwordText];
    
    rememberPasswordCheckButton = [[UIButton alloc] initWithFrame:CGRectMake(CHECKBUTTON_X, CHECKBUTTON_Y * SCREEN_HEIGHT, CHECKBUTTON_W, CHECKBUTTON_H * SCREEN_HEIGHT)];
    [rememberPasswordCheckButton setBackgroundColor:[UIColor lightGrayColor]];
    [rememberPasswordCheckButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [rememberPasswordCheckButton.layer setBorderWidth:1.0];
    checkbuttonImage = [UIImage imageNamed:@"checkbutton.png"];
    [rememberPasswordCheckButton setBackgroundImage: checkbuttonImage forState:UIControlStateNormal];
    isRememberPassword = YES;
    [rememberPasswordCheckButton addTarget:self action:@selector(rememberPasswordCheckButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rememberPasswordCheckButton];
    
    UILabel *rememberPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(REMEMBERPASSWORD_LABEL_X, REMEMBERPASSWORD_LABEL_Y * SCREEN_HEIGHT, REMEMBERPASSWORD_LABEL_W, REMEMBERPASSWORD_LABEL_H * SCREEN_HEIGHT)];
    rememberPasswordLabel.text = @"Remember password";
    rememberPasswordLabel.textAlignment = UITextAlignmentCenter;
    rememberPasswordLabel.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:rememberPasswordLabel];
    
    forgotPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(FORGOTPASSWORDBUTTON_X, FORGOTPASSWORDBUTTON_Y * SCREEN_HEIGHT, FORGOTPASSWORDBUTTON_W, FORGOTPASSWORDBUTTON_H * SCREEN_HEIGHT)];
    [forgotPasswordButton setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [forgotPasswordButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPasswordButton];
    
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(LOGINBUTTON_X, LOGINBUTTON_Y * SCREEN_HEIGHT, LOGINBUTTON_W, LOGINBUTTON_H * SCREEN_HEIGHT);
    [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(SIGNUPBUTTON_X, SIGNUPBUTTON_Y * SCREEN_HEIGHT, SIGNUPBUTTON_W, SIGNUPBUTTON_H * SCREEN_HEIGHT)];
    [signUpButton setTitle:@"Create a free account now!" forState:UIControlStateNormal];
    [signUpButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    signUpButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [signUpButton addTarget:self action:@selector(signUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    resendEmailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resendEmailButton.frame = CGRectMake(RESENDEMAILBUTTON_X, RESENDEMAILBUTTON_Y * SCREEN_HEIGHT, RESENDEMAILBUTTON_W, RESENDEMAILBUTTON_H * SCREEN_HEIGHT);
    [resendEmailButton setTitle:@"Re-Send Email" forState:UIControlStateNormal];
    [resendEmailButton addTarget:self action:@selector(resendEmailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:resendEmailButton];
    
    
}

- (void)loginWithFacebook
{
    [process loginWithFacebook];
}

- (void)rememberPasswordCheckButtonClick
{
    isRememberPassword = !isRememberPassword;
    if (isRememberPassword) {
        [rememberPasswordCheckButton setBackgroundImage: checkbuttonImage forState:UIControlStateNormal];
    } else {
        [rememberPasswordCheckButton setBackgroundImage:nil forState:UIControlStateNormal];
    }
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
    VSFForgotPasswordViewController *forgotPasswordViewController = [[VSFForgotPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgotPasswordViewController animated:YES];
    
    //    [process forgotPassword:@"hanqunhu@hengtiansoft.com"];
}

- (void)enterHomeView
{
    DDMenuController *loginMenuController = (DDMenuController *)((VSFAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    VSFPlaybookViewController *playbookController = [[VSFPlaybookViewController alloc] init];
    loginMenuController.leftViewController = playbookController;
    VSFHomeViewController *homeController = [[VSFHomeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeController];
    [loginMenuController setRootController:navController animated:YES];
    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, SCREEN_HEIGHT - 20 - 44, 320, 50);
    [loginMenuController.view addSubview:[VSFADBannerView getAdBannerView]];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFrame = textField.frame;
    float textY = textFrame.origin.y + textFrame.size.height;
    float bottomY = self.view.frame.size.height - textY;
    if (bottomY >= 216 + 30) {   // 216 is default keyboard height
        prewTag = -1;
        return;
    }
    prewTag = textField.tag;
    float moveY = 130; //216 - bottomY;
    prewMoveY = moveY;
    
    NSTimeInterval animationDuration = 0.3f;
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
    NSTimeInterval animationDuration = 0.3f;
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

- (void)passLoginInfo:(NSArray *)info
{
    NSString *fb_id = [info objectAtIndex:0];
    NSString *fb_name = [info objectAtIndex:1];
    [alertView setTitle:nil];
    [alertView setMessage:[NSString stringWithFormat:@"Welcome %@ ! Your ID is %@", fb_name, fb_id]];
    [alertView show];
}

#pragma mark - VSFSignUpViewControllerDelegate

- (void)setSignUpSuccessFlag
{
    [alertView setTitle:@"Notice"];
    [alertView setMessage:@"Sign Up successfully! Before login, you should verify email first."];
    [alertView show];
}

#pragma mark - VSFVerifyEmailViewDelegate
- (void)resendEmail:(NSString *)email
{
    [process resendEmailNotification:email];
}

- (void)close
{
    [verifyEmailView dismiss];
}

@end
