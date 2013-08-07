//
//  VSFCreateGameResponseEntity.m
//  VsFootball
//
//  Created by hjy on 8/7/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFCreateGameResponseEntity.h"

@implementation VSFCreateGameResponseEntity
@synthesize gameID;

- (id)init
{
    self = [super init];
    if (self) {
        gameID = [[NSString alloc] init];
    }
    return self;
}

@end
