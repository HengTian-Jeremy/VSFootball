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

/*!
    @class VSFLoginViewController
 
    @abstract view controller for login
 
    @discussion view controller for login
*/
@interface VSFLoginViewController : VSFViewController <VSFLoginProcessDelegate, VSFSignUpViewControllerDelegate> {
    
    VSFLoginProcess *process;
    VSFSignUpViewController *signUpVC;
        
    UILabel *usernameLabel;
    UILabel *passwordLabel;
    UITextField *usernameText;
    UITextField *passwordText;
    UIButton *loginButton;
    
    UIButton *signUpButton;
    UIButton *resendEmailButton;
    UIButton *forgotPasswordButton;
    
    UIAlertView *alertView;
}

@end
