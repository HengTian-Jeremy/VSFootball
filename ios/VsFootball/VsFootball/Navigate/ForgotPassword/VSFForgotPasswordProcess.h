//
//  VSFForgotPasswordProcess.h
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFForgotPasswordResponseEntity;

/*!
 @protocol VSFForgotPasswordProcessDelegate
 
 @abstract Forgot password process delegate
 
 @discussion Forgot password process delegate
 */
@protocol VSFForgotPasswordProcessDelegate <NSObject>
@optional
/*!
 @method setForgotPasswordResult:
 @abstract set the response data to delegate
 @discussion set the response data to delegate
 @param respEntity VSFForgotPasswordResponseEntity Entity
 @result void
 */
- (void)setForgotPasswordResult:(VSFForgotPasswordResponseEntity *)respEntity;

@end

@interface VSFForgotPasswordProcess : NSObject{
    VSFNetwork *forgotPasswordReq;
}

// Response data target
@property (nonatomic, assign) id<VSFForgotPasswordProcessDelegate> delegate;

/*!
 @method forgotPassword:
 @abstract forgotPassword interface
 @discussion forgotPassword interface
 @param email
 @result void
 */
- (void)forgotPassword:(NSString *)email;

@end
