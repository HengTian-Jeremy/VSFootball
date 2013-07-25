//
//  VSFLoginProcess.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFLoginProcess.h"

#import "VSFAppDelegate.h"
#import "VSFNetwork.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "VSFResponseEntity.h"
#import "VSFCommonDefine.h"

@interface VSFLoginProcess ()
{
    VSFNetwork *signInReq;
}

- (void)receiveLoginServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFLoginProcess

- (id)init
{
    self = [super init];
    if (self) {
        signInReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveLoginServerData:status:)];
    }
    return self;
}

- (void)dealloc
{
    [signInReq release];
    [super dealloc];
}

- (void)login:(NSString *)username withPassword:(NSString *)password
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", VSF_SERVER_ADDRESS, SIGNIN_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:username forKey:@"username"];
    [asiReq setPostValue:password forKey:@"password"];
    
    [signInReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}

#pragma mark - Private Methods

- (void)receiveLoginServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFResponseEntity *respInfo = [[VSFResponseEntity alloc] init];
        respInfo.success = [responseData valueForKey:@"success"];
        respInfo.message = [responseData valueForKey:@"message"];
        respInfo.guid = [responseData valueForKey:@"guid"];
        
        [self.delegate setLoginResult:respInfo];
        [respInfo release];
    } else {
        NSLog(@"sign in request failed.");
    }
}

@end
