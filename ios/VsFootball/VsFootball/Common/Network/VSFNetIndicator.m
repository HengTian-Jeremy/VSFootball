//
//  VSFNetIndicator.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFNetIndicator.h"

VSFNetIndicator *erGlobalNetworkIndicator = nil;

@implementation VSFNetIndicator

@synthesize isVisible;

- (id)init
{
    self = [super init];
    if (self) {
        countLock = [[NSCondition alloc] init];
        activeCount = 0;
        isActived = NO;
    }
    return self;
}

- (void)dealloc
{
    [countLock release];
    [super dealloc];
}

- (void)setIsVisible:(BOOL)visible;
{
    [countLock lock];
    if (visible) {
        activeCount += 1;
    } else {
        activeCount -= 1;
    }
    // have set
    if (activeCount == 0 && isActived) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        isActived = NO;
    }
    // have not set
    if (activeCount > 0 && !isActived) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        isActived = YES;
    }
    [countLock unlock];
}

+ (VSFNetIndicator *)defaultIndicator
{
    @synchronized(self) {
        if (!erGlobalNetworkIndicator) {
            erGlobalNetworkIndicator = [[VSFNetIndicator alloc] init];
        }
    }
    return erGlobalNetworkIndicator;
}

+ (void)releasedefaultIndicator
{
    [erGlobalNetworkIndicator release];
}
@end
