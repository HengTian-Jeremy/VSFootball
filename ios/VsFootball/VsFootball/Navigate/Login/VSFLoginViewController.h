//
//  VSFLoginViewController.h
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFViewController.h"
#import "VSFLoginProcess.h"
#import "VSFSignUpViewController.h"
#import "VSFVerifyEmailView.h"

/*!
 @class VSFLoginViewController
 
 @abstract view controller for login
 
 @discussion view controller for login
 */
@interface VSFLoginViewController : VSFViewController <VSFLoginProcessDelegate, VSFSignUpViewControllerDelegate, VSFVerifyEmailViewDelegate, UITextFieldDelegate> {
    
    int prewTag;
    float prewMoveY;
    BOOL isRememberPassword;
    
    VSFLoginProcess *process;
    VSFSignUpViewController *signUpVC;
    
    UILabel *usernameLabel;
    UILabel *passwordLabel;
    UITextField *usernameText;
    UITextField *passwordText;
    UIImage *checkbuttonImage;
    UIButton *rememberPasswordCheckButton;
    UIButton *loginButton;    
    UIButton *signUpButton;
    UIButton *resendEmailButton;
    UIButton *forgotPasswordButton;
    
    VSFVerifyEmailView *verifyEmailView;
    
    UIAlertView *alertView;
}

@end
