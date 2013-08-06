//
//  VSFFacebookFriends.m
//  VsFootball
//
//  Created by Jessie Hu on 13-8-6.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFFacebookFriends.h"

static VSFFacebookFriends *facebookFriends;

@implementation VSFFacebookFriends

@synthesize friendsList;

+ (VSFFacebookFriends *)getFacebookFriends
{
    @synchronized([VSFFacebookFriends class]) {
        if(!facebookFriends) {
            facebookFriends = [[self alloc] init];
        }
        return  facebookFriends;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        friendsList = [[NSArray alloc] init];
    }
    return self;
}

@end
