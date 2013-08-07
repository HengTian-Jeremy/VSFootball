//
//  VSFCreateGameEntity.m
//  VsFootball
//
//  Created by hjy on 8/7/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFCreateGameEntity.h"

@implementation VSFCreateGameEntity
@synthesize inviteEmail, possession, teamName, playIDSelected;

- (id)init
{
    self = [super init];
    if (self) {
        inviteEmail = [[NSString alloc] init];
        possession = [[NSString alloc] init];
        teamName = [[NSString alloc] init];
        playIDSelected = [[NSString alloc] init];
    }
    return self;
}

@end
