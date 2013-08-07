//
//  VSFEmailProcess.h
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFInviteToJoinEntity;

/*!
 @protocol VSFEmailProcessDelegate
 
 @abstract Email process delegate
 
 @discussion Email process delegate
 */
@protocol VSFEmailProcessDelegate <NSObject>
@optional
/*!
 @method setEmailResult:
 @abstract set the response data to delegate
 @discussion set the response data to delegate
 @param respEntity VSFInviteToJoinEntity Entity
 @result void
 */
- (void)setInviteByEmailResult:(VSFInviteToJoinEntity *)respEntity;
@end

@interface VSFEmailProcess : NSObject {
    VSFNetwork *inviteByEmailReq;
}

// Response data target
@property (nonatomic, assign) id<VSFEmailProcessDelegate> delegate;

/*!
 @method inviteByEmail:
 @abstract invite by email interface
 @discussion invite by email interface
 @param email
 @result void
 */
- (void)inviteByEmail:(NSString *)email;

@end
