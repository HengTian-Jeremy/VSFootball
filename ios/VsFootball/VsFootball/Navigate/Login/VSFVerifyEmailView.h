//
//  VSFVerifyEmailView.h
//  VsFootball
//
//  Created by hjy on 7/29/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 @protocol VSFVerifyEmailViewDelegate
 
 @abstract VerifyEmail View Delegate
 
 @discussion VerifyEmail View Delegate
 */
@protocol VSFVerifyEmailViewDelegate <NSObject>
@optional
/*!
 @method sendEmailWhenForgotPassword
 @abstract send email when forgot password
 @discussion send email when forgot password
 @param email user email
 @result void
 */
- (void)sendEmailWhenForgotPassword:(NSString *)email;

/*!
@method resendEmail
@abstract resend email
@discussion resend email
@param email user email
@result void
*/
- (void)resendEmail:(NSString *)email;

/*!
 @method close
 @abstract close view
 @discussion close view
 @param NULL
 @result void
 */
- (void)close;

@end

/*!
 @class VSFVerifyEmailView
 
 @abstract VerifyEmail view
 
 @discussion VerifyEmail view
 */
@interface VSFVerifyEmailView : UIView<UITextFieldDelegate>{
    UILabel *titleLabel;
    UITextField *emailTextField;
    UIButton *sendEmailButton;
    UIButton *closeButton;
    UIControl *overlayView;
    
    UIAlertView *alertView;
}

// Response data target
@property (nonatomic, assign) id<VSFVerifyEmailViewDelegate> delegate;
@property (nonatomic, retain) NSString *type;
/*!
 @method setTitle
 @abstract set title
 @discussion set title
 @param title message title
 @result void
 */
- (void)setTitle:(NSString *)title;

/*!
 @method show
 @abstract show view
 @discussion show view
 @param NULL
 @result void
 */
- (void)show;

/*!
 @method dismiss
 @abstract dismiss view
 @discussion dismiss view
 @param NULL
 @result void
 */
- (void)dismiss;


@end
