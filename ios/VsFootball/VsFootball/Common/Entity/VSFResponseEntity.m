//
//  VSFResponseEntity.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFResponseEntity.h"

@implementation VSFResponseEntity

- (id)init
{
    self = [super init];
    if (self) {
        _success = [[NSString alloc] init];
        _message = [[NSString alloc] init];
        _guid = [[NSString alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_success release], _success = nil;
    [_message release], _message = nil;
    [_guid release], _guid = nil;
    [super dealloc];
}

@end
