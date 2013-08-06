//
//  VSFSignUpViewController.h
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFViewController.h"
#import "VSFSignUpProcess.h"

/*!
    @protocol VSFSignUpViewControllerDelegate
 
    @abstract SignUp ViewController delegate
 
    @discussion SignUp ViewController delegate
*/
@protocol VSFSignUpViewControllerDelegate <NSObject>
/*!
    @method setSignUpSuccessFlag
    @abstract set signup success flag to delegate
    @discussion set signup success flag to delegate
    @param NULL
    @result void
*/
- (void)setSignUpSuccessFlag;

@end

/*!
    @class VSFSignUpViewController
 
    @abstract view controller for sign up
 
    @discussion view controller for sign up
*/
@interface VSFSignUpViewController : VSFViewController <VSFSignUpProcessDelegate, UITextFieldDelegate> {
    
    int prewTag;
    float prewMoveY;
    
    VSFSignUpProcess *process;
    UITextField *emailText;
    UITextField *passwordText;
    UITextField *confirmPasswordText;
    UITextField *firstnameText;
    UITextField *lastnameText;
    UIButton *signUpButton;
    UIScrollView *scrollView;
}

// Response data target
@property (nonatomic, assign) id<VSFSignUpViewControllerDelegate> delegate;

@end
