//
//  VSFUtility.h
//  VsFootball
//
//  Created by Jessie Hu on 13-7-23.
//  Copyright (c) 2013年 Jessie Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFSignUpEntity;

/*!
    @class VSFUtility
 
    @abstract utility class
 
    @discussion utility class
*/
@interface VSFUtility : NSObject

/*!
    @method encrypt:
    @abstract password SHA-1 encryption
    @discussion password SHA-1 encryption
    @param password
    @result password after encrypt
*/
+ (NSString *)encrypt:(NSString *)password;

/*!
    @method validateSignInInfo:withPassword:
    @abstract validate login info
    @discussion validate login info with username and password
    @param name username
    @param pwd password
    @result validation result
*/
+ (NSString *)validateSignInInfo:(NSString *)name withPassword:(NSString *)pwd;

/*!
    @method validateSignUpInfo:
    @abstract validate sign up info
    @discussion validate sign up info with VSFSignUpEntity entity
    @param entity VSFSignUpEntity entity
    @result validation result
*/
+ (NSString *)validateSignUpInfo:(VSFSignUpEntity *)entity;

/*!
    @method checkNetwork
    @abstract check current network state
    @discussion check current network state
    @param NULL
    @result network state
*/
+ (int)checkNetwork;

@end
