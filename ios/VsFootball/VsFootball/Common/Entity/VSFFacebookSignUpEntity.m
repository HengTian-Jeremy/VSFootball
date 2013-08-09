//
//  VSFFacebookSignUpEntity.m
//  VsFootball
//
//  Created by Jessie Hu on 13-8-8.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFFacebookSignUpEntity.h"

@implementation VSFFacebookSignUpEntity

@synthesize email, accountType, accessToken, tokenExpiration, firstname, lastname;

- (id)init
{
    self = [super init];
    if (self) {
        email = [[NSString alloc] init];
        accountType = [[NSString alloc] init];
        accessToken = [[NSString alloc] init];
        tokenExpiration = 0;
        firstname = [[NSString alloc] init];
        lastname = [[NSString alloc] init];
    }
    return self;
}

@end
