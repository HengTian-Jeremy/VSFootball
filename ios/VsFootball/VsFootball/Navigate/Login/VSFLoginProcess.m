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
#import "VSFFacebookFriends.h"
#import "VSFFacebookSignUpEntity.h"
#import "VSFSignUpResponseEntity.h"

@interface VSFLoginProcess ()

- (void)receiveLoginServerData:(NSString *)data status:(NSString *)status;
- (void)receiveResendEmailNotificationServerData:(NSString *)data status:(NSString *)status;
- (void)receiveFacebookSignUpServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFLoginProcess

- (id)init
{
    self = [super init];
    if (self) {
        signInReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveLoginServerData:status:)];
        resendEmailNotificationReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveResendEmailNotificationServerData:status:)];
        facebookSignUpReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveFacebookSignUpServerData:status:)];
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

- (void)loginWithFacebook
{
    VSFAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.fbSession = [[FBSession alloc] init];
    [FBSession setActiveSession:appDelegate.fbSession];
    
    [appDelegate.fbSession openWithBehavior:FBSessionLoginBehaviorWithNoFallbackToWebView completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {

        NSLog(@"token: %@", appDelegate.fbSession.accessTokenData.accessToken);
        
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
            if (!error) {
                
                VSFFacebookSignUpEntity * facebookEntity = [[VSFFacebookSignUpEntity alloc] init];
                facebookEntity.email = @"278570662@qq.com";
                facebookEntity.accountType = [NSString stringWithFormat:@"facebook:%@", user.id];
                facebookEntity.accessToken = appDelegate.fbSession.accessTokenData.accessToken;
                facebookEntity.tokenExpiration = [appDelegate.fbSession.accessTokenData.expirationDate timeIntervalSince1970];
                facebookEntity.firstname = user.first_name;
                facebookEntity.lastname = user.last_name;
                facebookEntity.platform = @"iOS";
                
                [self.delegate passFacebookUserInfo:facebookEntity];
            }
        }];
        
        [[FBRequest requestForMyFriends] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                
                NSDictionary *dic = (NSDictionary *)result;
                NSArray *myFriends = [dic objectForKey:@"data"];
                [VSFFacebookFriends getFacebookFriends].friendsList = myFriends;
            }
        }];
    }];
}

- (void)facebookSignUp:(VSFFacebookSignUpEntity *)entity;
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", VSF_SERVER_ADDRESS, SIGNUP_FACEBOOK_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:entity.email forKey:@"email"];
    [asiReq setPostValue:entity.accountType forKey:@"accounttype"];
    [asiReq setPostValue:entity.accessToken forKey:@"accesstoken"];
    [asiReq setPostValue:[NSNumber numberWithInt:entity.tokenExpiration] forKey:@"tokenexpiration"];
    [asiReq setPostValue:entity.firstname forKey:@"firstname"];
    [asiReq setPostValue:entity.lastname forKey:@"lastname"];
    [asiReq setPostValue:entity.platform forKey:@"platform"];
    
    [facebookSignUpReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
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
        [self.delegate setLoginResult:nil];
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

- (void)receiveFacebookSignUpServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFSignUpResponseEntity *respEntity = [[VSFSignUpResponseEntity alloc] init];
        respEntity.success = [responseData objectForKey:@"Success"];
        respEntity.message = [responseData objectForKey:@"Message"];
        respEntity.guid = [responseData objectForKey:@"Guid"];

        [self.delegate setFacebookSignUpResult:respEntity];
    } else {
        NSLog(@"facebook sign up request failed.");
    }
}

@end
