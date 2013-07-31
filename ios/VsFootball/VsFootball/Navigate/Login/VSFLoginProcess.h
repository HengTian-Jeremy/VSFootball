//
//  VSFLoginProcess.h
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFLoginResponseEntity;
@class VSFResendEmailNotificationResponseEntity;

/*!
    @protocol VSFLoginProcessDelegate
 
    @abstract Login process delegate
 
    @discussion Login process delegate
*/
@protocol VSFLoginProcessDelegate <NSObject>
@optional
/*!
    @method setSignInResult:
    @abstract set the response data to delegate
    @discussion set the response data to delegate
    @param respEntity VSFLoginResponseEntity Entity
    @result void
*/
- (void)setLoginResult:(VSFLoginResponseEntity *)respEntity;

/*!
    @method setResendEmailNotificationResult:
    @abstract set the response data to delegate
    @discussion set the response data to delegate
    @param respEntity VSFResendEmailNotificationResponseEntity Entity
    @result void
*/
- (void)setResendEmailNotificationResult:(VSFResendEmailNotificationResponseEntity *)respEntity;

@end

/*!
    @class VSFLoginProcess
 
    @abstract Login processor
 
    @discussion Login processor
*/
@interface VSFLoginProcess : NSObject {

    VSFNetwork *signInReq;
    VSFNetwork *resendEmailNotificationReq;
}

// Response data target
@property (nonatomic, assign) id<VSFLoginProcessDelegate> delegate;

/*!
    @method login:withPassword:
    @abstract login interface
    @discussion login interface
    @param email user account
    @param password user password
    @result void
*/
- (void)login:(NSString *)username withPassword:(NSString *)password;

/*!
    @method resendEmailNotification:
    @abstract resendEmailNotification interface
    @discussion resendEmailNotification interface
    @param email
    @result void
*/
- (void)resendEmailNotification:(NSString *)email;

@end
