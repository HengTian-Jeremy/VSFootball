//
//  VSFSignUpEntity.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-24.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFSignUpEntity.h"

@implementation VSFSignUpEntity

- (id)init
{
    self = [super init];
    if (self) {
        _email = [[NSString alloc] init];
        _password = [[NSString alloc] init];
        _firstname = [[NSString alloc] init];
        _lastname = [[NSString alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_email release], _email = nil;
    [_password release], _password = nil;
    [_firstname release], _firstname = nil;
    [_lastname release], _lastname = nil;
    [super dealloc];
}

@end
