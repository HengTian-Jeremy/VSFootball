//
//  VSFInviteToJoinEntity.m
//  VsFootball
//
//  Created by hjy on 8/7/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFInviteToJoinEntity.h"

@implementation VSFInviteToJoinEntity

@synthesize guid;

- (id)init
{
    self = [super init];
    if (self) {
        guid = [[NSString alloc] init];
    }
    return self;
}

@end
