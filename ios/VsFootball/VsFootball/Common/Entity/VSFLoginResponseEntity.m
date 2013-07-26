//
//  VSFLoginResponseEntity.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-26.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFLoginResponseEntity.h"

@implementation VSFLoginResponseEntity

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
