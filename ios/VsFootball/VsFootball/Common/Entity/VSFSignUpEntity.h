//
//  VSFSignUpEntity.h
//  VsFootball
//
//  Created by Jessie Hu on 13-7-24.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSFSignUpEntity : NSObject

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *confirmPassword;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *lastname;

@end
