//
//  VSFNetwork.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFNetwork.h"
#import "VSFNetIndicator.h"


@implementation VSFNetwork

// init
- (id)initWithTarget:(id)target selector:(SEL)selector
{			
    self = [super init];
    if (self) {
        // save obj
        targetObj = target;
        //  save obj selector
        targetSelector = selector;
    }
    return self;
}

// asynchronous request
- (void)startRequest:(ASIHTTPRequest *)requestObj activeIndicator:(BOOL)activeIndicator needInteract:(BOOL)needInteract parent:(id)parent
{
    // save net waiting flag
    networkIndicator = activeIndicator;
    isInterract = needInteract;
    asiReq = requestObj;
    
    [asiReq setDelegate:self];
    
    [asiReq startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request 
{  
    NSString *responseString = [request responseString];
    
    if (targetObj != nil) {
        [targetObj performSelector:targetSelector withObject:responseString withObject:@"0"];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request 
{
    NSError *error = [request error];
    NSLog(@"requestFailed:%@",error);
    
    if (targetObj != nil) {
        [targetObj performSelector:targetSelector withObject:nil withObject:@"1"];
    }
} 

@end
