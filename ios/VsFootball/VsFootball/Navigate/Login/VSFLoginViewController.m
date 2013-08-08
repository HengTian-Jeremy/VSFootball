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
#import "VSFReadAndWriteFile.h"

// Title Label
#define TITLE_LABEL_X 0
#define TITLE_LABEL_Y 0.0938
#define TITLE_LABEL_W 320
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
#define OR_LABEL_X 0
#define OR_LABEL_Y 0.4167
#define OR_LABEL_W 320
#define OR_LABEL_H 0.0417
// Login describe Label
#define LOGINDESCRIBE_LABEL_X 0
#define LOGINDESCRIBE_LABEL_Y 0.4583
#define LOGINDESCRIBE_LABEL_W 320
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
// Logining ActivityIndicator View
#define LOGINING_ACTIVITYINDICATOR_VIEW_X 0
#define LOGINING_ACTIVITYINDICATOR_VIEW_Y 0
#define LOGINING_ACTIVITYINDICATOR_VIEW_W 320
#define LOGINING_ACTIVITYINDICATOR_VIEW_H 1
// ScrollView for Main of ContentSize
#define SCROLL_VIEW_W 320
#define SCROLL_VIEW_H 1.5

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
- (void)endEditing;

@end

@implementation VSFLoginViewController {
    NSMutableDictionary *writeDataDictionary;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        writeDataDictionary = [[NSMutableDictionary alloc] init];
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
    [self endEditing];
}

#pragma mark - Private Methods

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setContentSize:CGSizeMake(SCROLL_VIEW_W, SCROLL_VIEW_H * SCREEN_HEIGHT)];
    [scrollView setDelaysContentTouches:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollEnabled:NO];    
    [self.view addSubview:scrollView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y * SCREEN_HEIGHT, TITLE_LABEL_W, TITLE_LABEL_H * SCREEN_HEIGHT)];
    titleLabel.text = @"Vs. Football";
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"SketchRockwell" size:30.0];
    [scrollView addSubview:titleLabel];
    
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    facebookButton.frame = CGRectMake(FACEBOOK_BUTTON_X, FACEBOOK_BUTTON_Y * SCREEN_HEIGHT, FACEBOOK_BUTTON_W, FACEBOOK_BUTTON_H * SCREEN_HEIGHT);
    [facebookButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(loginWithFacebook) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:facebookButton];
    
    UILabel *facebookdescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(FACEBOOKDESCRIBE_LABEL_X,FACEBOOKDESCRIBE_LABEL_Y * SCREEN_HEIGHT,FACEBOOKDESCRIBE_LABEL_W,FACEBOOKDESCRIBE_LABEL_H * SCREEN_HEIGHT)];
    facebookdescribeLabel.text = @"Use Facebook signin to chanllenge your friends today!";
    facebookdescribeLabel.textAlignment = UITextAlignmentCenter;
    facebookdescribeLabel.font = [UIFont fontWithName:@"SketchRockwell" size:17.0];
    facebookdescribeLabel.numberOfLines = 0;
    [scrollView addSubview:facebookdescribeLabel];
    
    UILabel *orLabel = [[UILabel alloc] initWithFrame:CGRectMake(OR_LABEL_X, OR_LABEL_Y * SCREEN_HEIGHT, OR_LABEL_W, OR_LABEL_H * SCREEN_HEIGHT)];
    orLabel.text = @"Or";
    orLabel.textAlignment = UITextAlignmentCenter;
    orLabel.font = [UIFont fontWithName:@"SketchRockwell" size:17.0];
    [scrollView addSubview:orLabel];
    
    UILabel *logindescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(LOGINDESCRIBE_LABEL_X, LOGINDESCRIBE_LABEL_Y * SCREEN_HEIGHT, LOGINDESCRIBE_LABEL_W, LOGINDESCRIBE_LABEL_H * SCREEN_HEIGHT)];
    logindescribeLabel.text = @"Login with Vs. Football signon";
    logindescribeLabel.textAlignment = UITextAlignmentCenter;
    logindescribeLabel.font = [UIFont fontWithName:@"SketchRockwell" size:17.0];
    [scrollView addSubview:logindescribeLabel];
    
    usernameText = [[UITextField alloc] init];
    usernameText.frame = CGRectMake(USERNAMETEXT_X, USERNAMETEXT_Y * SCREEN_HEIGHT, USERNAMETEXT_W, USERNAMETEXT_H * SCREEN_HEIGHT);
    usernameText.borderStyle = UITextBorderStyleRoundedRect;
    usernameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameText.placeholder = @"Username";
    usernameText.keyboardType = UIKeyboardTypeEmailAddress;
    usernameText.tag = 1;
    usernameText.delegate = self;
    [scrollView addSubview:usernameText];
    
    passwordText = [[UITextField alloc] init];
    passwordText.frame = CGRectMake(PASSWORDTEXT_X, PASSWORDTEXT_Y * SCREEN_HEIGHT, PASSWORDTEXT_W, PASSWORDTEXT_H * SCREEN_HEIGHT);
    passwordText.borderStyle = UITextBorderStyleRoundedRect;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordText.placeholder = @"Password";
    passwordText.keyboardType = UIKeyboardTypeEmailAddress;
    passwordText.secureTextEntry = YES;
    passwordText.tag = 2;
    passwordText.delegate = self;
    [scrollView addSubview:passwordText];

    rememberPasswordCheckButton = [[UIButton alloc] initWithFrame:CGRectMake(CHECKBUTTON_X, CHECKBUTTON_Y * SCREEN_HEIGHT, CHECKBUTTON_W, CHECKBUTTON_H * SCREEN_HEIGHT)];
    [rememberPasswordCheckButton setBackgroundColor:[UIColor lightGrayColor]];
    [rememberPasswordCheckButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [rememberPasswordCheckButton.layer setBorderWidth:1.0];
    checkbuttonImage = [UIImage imageNamed:@"checkbutton.png"];
    [rememberPasswordCheckButton setBackgroundImage: checkbuttonImage forState:UIControlStateNormal];
    isRememberPassword = YES;
    [rememberPasswordCheckButton addTarget:self action:@selector(rememberPasswordCheckButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:rememberPasswordCheckButton];
    
    UILabel *rememberPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(REMEMBERPASSWORD_LABEL_X, REMEMBERPASSWORD_LABEL_Y * SCREEN_HEIGHT, REMEMBERPASSWORD_LABEL_W, REMEMBERPASSWORD_LABEL_H * SCREEN_HEIGHT)];
    rememberPasswordLabel.text = @"Remember password";
    rememberPasswordLabel.textAlignment = UITextAlignmentCenter;
    rememberPasswordLabel.font = [UIFont fontWithName:@"SketchRockwell" size:14.0];
    [scrollView addSubview:rememberPasswordLabel];
    
    forgotPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(FORGOTPASSWORDBUTTON_X, FORGOTPASSWORDBUTTON_Y * SCREEN_HEIGHT, FORGOTPASSWORDBUTTON_W, FORGOTPASSWORDBUTTON_H * SCREEN_HEIGHT)];
    [forgotPasswordButton setTitle:@"Forgot password?" forState:UIControlStateNormal];
    forgotPasswordButton.titleLabel.font = [UIFont fontWithName:@"SketchRockwell" size:15.0];
    [forgotPasswordButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:forgotPasswordButton];
    
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.frame = CGRectMake(LOGINBUTTON_X, LOGINBUTTON_Y * SCREEN_HEIGHT, LOGINBUTTON_W, LOGINBUTTON_H * SCREEN_HEIGHT);
    [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:loginButton];
    
    signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(SIGNUPBUTTON_X, SIGNUPBUTTON_Y * SCREEN_HEIGHT, SIGNUPBUTTON_W, SIGNUPBUTTON_H * SCREEN_HEIGHT)];
    [signUpButton setTitle:@"Create a free account now!" forState:UIControlStateNormal];
    signUpButton.titleLabel.font = [UIFont fontWithName:@"SketchRockwell" size:15.0];
    [signUpButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    signUpButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [signUpButton addTarget:self action:@selector(signUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:signUpButton];
    
    resendEmailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resendEmailButton.frame = CGRectMake(RESENDEMAILBUTTON_X, RESENDEMAILBUTTON_Y * SCREEN_HEIGHT, RESENDEMAILBUTTON_W, RESENDEMAILBUTTON_H * SCREEN_HEIGHT);
    [resendEmailButton setTitle:@"Re-Send Email" forState:UIControlStateNormal];
    [resendEmailButton addTarget:self action:@selector(resendEmailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:resendEmailButton];
    
    loginingIndicatorView = [[VSFIndicatorView alloc] initWithFrame:CGRectMake(LOGINING_ACTIVITYINDICATOR_VIEW_X, LOGINING_ACTIVITYINDICATOR_VIEW_Y * SCREEN_HEIGHT, LOGINING_ACTIVITYINDICATOR_VIEW_W, LOGINING_ACTIVITYINDICATOR_VIEW_H * SCREEN_HEIGHT)];
    
    NSMutableDictionary *readData = [VSFReadAndWriteFile readData:@"UserInfo"];
    if ([readData objectForKey:@"Username"]) {
        usernameText.text = [readData objectForKey:@"Username"];
        passwordText.text = [readData objectForKey:@"Password"];
    }
}

- (void)loginWithFacebook
{
    [self endEditing];
    [process loginWithFacebook];
}

- (void)rememberPasswordCheckButtonClick
{
    isRememberPassword = !isRememberPassword;
    if (isRememberPassword) {
        [rememberPasswordCheckButton setBackgroundImage: checkbuttonImage forState:UIControlStateNormal];
        
        [writeDataDictionary setObject:usernameText.text forKey:@"Username"];
        [writeDataDictionary setObject:passwordText.text forKey:@"Password"];
        [VSFReadAndWriteFile writeData:writeDataDictionary fileName:@"UserInfo"];        
    } else {
        [rememberPasswordCheckButton setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

- (void)loginButtonClick
{
    [self endEditing];
    NSString *validateResult = [VSFUtility validateSignInInfo:usernameText.text withPassword:passwordText.text];
    if ([validateResult isEqualToString:@"SUCCESS"]) {
        NSLog(@"Validate Success.");
        if ([VSFUtility checkNetwork]) {
            if (isRememberPassword) {
                [writeDataDictionary setObject:usernameText.text forKey:@"Username"];
                [writeDataDictionary setObject:passwordText.text forKey:@"Password"];
                [VSFReadAndWriteFile writeData:writeDataDictionary fileName:@"UserInfo"];
            }
            
            NSString *encryptPassword = [VSFUtility encrypt:passwordText.text];
            [process login:usernameText.text withPassword:encryptPassword];
            
            [self.view addSubview:loginingIndicatorView];// show the loginingIndicatorView
        }
    } else {
        [alertView setTitle:@"Notice"];
        [alertView setMessage:validateResult];
        [alertView show];
    }
//    [self enterHomeView];
}

- (void)signUpButtonClick
{
    [self endEditing];
    signUpVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController presentModalViewController:signUpVC animated:YES];
}

-(void)resendEmailButtonClick
{
    [self endEditing];
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
    [self endEditing];
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

- (void)endEditing {
    CGRect frame = scrollView.frame;
    frame.origin.y = 0;
    frame.origin.x = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    [scrollView setScrollEnabled:NO];
    [passwordText resignFirstResponder];
    [usernameText resignFirstResponder];
}

//- (void)writeData
//{
//    plistPath = [[NSBundle mainBundle] pathForResource:@"UserInfo" ofType:@"plist"];
//    data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    [data setObject:usernameText.text forKey:@"Username"];
//    [data setObject:passwordText.text forKey:@"Password"];
//    [data writeToFile:plistFile atomically:YES ];
//    paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    documentsDirectory = [paths objectAtIndex:0];
//    plistFile = [documentsDirectory stringByAppendingPathComponent:@"UserInfo.plist"];
//    [data writeToFile:plistFile atomically:YES];
//}

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

#pragma mark - LoginProcessDelegate

- (void)setLoginResult:(VSFLoginResponseEntity *)respEntity
{
    [loginingIndicatorView removeFromSuperview];// remove the loginingIndicatorView
    
    if (respEntity != nil) {
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
            
            [[NSUserDefaults standardUserDefaults] setObject:respEntity.guid forKey:@"GUID"];
            NSLog(@"%@", respEntity.guid);
            [Flurry logEvent:@"LOGIN_SUCCESS"];
        }        
    }
    
//    [self enterHomeView];

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
    alertView.tag = 1001;
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

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        [self enterHomeView];
    }
}

@end
