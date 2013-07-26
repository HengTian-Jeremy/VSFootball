//
//  VSFResponseEntity.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFResponseEntity.h"

@implementation VSFResponseEntity

@synthesize success, message;

- (id)init
{
    self = [super init];
    if (self) {
        success = [[NSString alloc] init];
        message = [[NSString alloc] init];
    }
    return self;
}

@end
