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
#import "VSFCommonDefine.h"
#import "VSFLoginResponseEntity.h"
#import "VSFResendEmailNotificationResponseEntity.h"
#import "VSFForgotPasswordResponseEntity.h"

@interface VSFLoginProcess ()

- (void)receiveLoginServerData:(NSString *)data status:(NSString *)status;
- (void)receiveResendEmailNotificationServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFLoginProcess

- (id)init
{
    self = [super init];
    if (self) {
        signInReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveLoginServerData:status:)];
        resendEmailNotificationReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveResendEmailNotificationServerData:status:)];
    }
    return self;
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

- (void)resendEmailNotification:(NSString *)email
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", VSF_SERVER_ADDRESS, SEND_EMAIL_NOTI_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:email forKey:@"email"];
    
    [resendEmailNotificationReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}

#pragma mark - Private Methods

- (void)receiveLoginServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFLoginResponseEntity *respInfo = [[VSFLoginResponseEntity alloc] init];
        respInfo.success = [responseData objectForKey:@"Success"];
        respInfo.message = [responseData objectForKey:@"Message"];
        respInfo.guid = [responseData objectForKey:@"Guid"];
        
        [self.delegate setLoginResult:respInfo];
    } else {
        NSLog(@"sign in request failed.");
    }
}

- (void)receiveResendEmailNotificationServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFResendEmailNotificationResponseEntity *respInfo = [[VSFResendEmailNotificationResponseEntity alloc] init];
        respInfo.success = [responseData objectForKey:@"Success"];
        respInfo.message = [responseData objectForKey:@"Message"];
        
        [self.delegate setResendEmailNotificationResult:respInfo];
    } else {
        NSLog(@"resend email notification request failed.");
    }
}

@end
