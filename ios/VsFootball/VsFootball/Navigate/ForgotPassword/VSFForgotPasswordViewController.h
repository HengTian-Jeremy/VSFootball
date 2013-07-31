//
//  VSFForgotPasswordViewController.h
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSFForgotPasswordProcess.h"

/*!
 @class VSFForgotPasswordViewController
 
 @abstract view controller for forgot password
 
 @discussion view controller for forgot password
 */
@interface VSFForgotPasswordViewController : UIViewController <VSFForgotPasswordProcessDelegate, UITextFieldDelegate>{
    float prewMoveY;
    
    VSFForgotPasswordProcess *process;
    
    UILabel *titleLabel;
    UILabel *messageLabel;
    UITextField *emailTextField;
    UIButton *cancelButton;
    UIButton *submitButton;
    
    UIAlertView *alertView;
}

@end
