//
//  VSFUtility.h
//  VsFootball
//
//  Created by Jessie Hu on 13-7-23.
//  Copyright (c) 2013年 Jessie Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFSignUpEntity;

@interface VSFUtility : NSObject

+ (NSString *)encrypt:(NSString *)password;

+ (NSString *)validateSignInInfo:(NSString *)name withPassword:(NSString *)pwd;
+ (NSString *)validateSignUpInfo:(VSFSignUpEntity *)entity;

+ (int)checkNetwork;

@end