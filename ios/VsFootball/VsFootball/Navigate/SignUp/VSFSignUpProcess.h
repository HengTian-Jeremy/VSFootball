//
//  VSFSignUpProcess.h
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFSignUpEntity;
@class VSFSignUpResponseEntity;


/*!
    @protocol VSFSignUpProcessDelegate
 
    @abstract SignUp process delegate
 
    @discussion SignUp process delegate
*/
@protocol VSFSignUpProcessDelegate <NSObject>
/*!
    @method setSignUpResult:
    @abstract set the response data to delegate
    @discussion set the response data to delegate
    @param respEntity VSFSignUpResponseEntity Entity
    @result void
*/
- (void)setSignUpResult:(VSFSignUpResponseEntity *)respEntity;

@end

/*!
    @class VSFSignUpProcess
 
    @abstract SignUp processor
 
    @discussion SignUp processor
*/
@interface VSFSignUpProcess : NSObject {
    
    VSFNetwork *signUpReq;
}
// Response data target
@property (nonatomic, assign) id<VSFSignUpProcessDelegate> delegate;

/*!
    @method signUp:
    @abstract signUp interface
    @discussion signUp interface
    @param entity SignUpEntity
    @result void
*/
- (void)signUp:(VSFSignUpEntity *)entity;

@end
