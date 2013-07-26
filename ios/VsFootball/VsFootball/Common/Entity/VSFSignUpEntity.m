//
//  VSFSignUpEntity.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-24.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFSignUpEntity.h"

@implementation VSFSignUpEntity

@synthesize email, password, firstname, lastname;

- (id)init
{
    self = [super init];
    if (self) {
        email = [[NSString alloc] init];
        password = [[NSString alloc] init];
        firstname = [[NSString alloc] init];
        lastname = [[NSString alloc] init];
    }
    return self;
}

@end
