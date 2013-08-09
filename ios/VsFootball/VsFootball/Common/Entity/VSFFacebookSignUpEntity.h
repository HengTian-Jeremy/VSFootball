//
//  VSFFacebookSignUpEntity.h
//  VsFootball
//
//  Created by Jessie Hu on 13-8-8.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSFFacebookSignUpEntity : NSObject

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *accountType;
@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, assign) int tokenExpiration;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *platform;

@end
