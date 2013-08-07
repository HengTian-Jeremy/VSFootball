//
//  VSFFeedbackEntity.m
//  VsFootball
//
//  Created by hjy on 8/7/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFFeedbackEntity.h"

@implementation VSFFeedbackEntity
@synthesize comment, gameID, screen;

- (id)init
{
    self = [super init];
    if (self) {
        comment = [[NSString alloc] init];
        gameID = [[NSString alloc] init];
        screen = [[NSString alloc] init];
    }
    return self;
}

@end
