//
//  VSFSendEmailNotificationProcess.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-25.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFSendEmailNotificationProcess.h"

#import "VSFAppDelegate.h"
#import "VSFNetwork.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "VSFResponseEntity.h"
#import "VSFCommonDefine.h"

@interface VSFSendEmailNotificationProcess ()
{
    VSFNetwork *sendEmailNotiReq;
}

- (void)receiveSendEmailNotificationServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFSendEmailNotificationProcess

- (id)init
{
    self = [super init];
    if (self) {
        sendEmailNotiReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveSendEmailNotificationServerData:status:)];
    }
    return self;
}

- (void)dealloc
{
    [sendEmailNotiReq release];
    [super dealloc];
}

- (void)SendEmailNotification:(NSString *)email
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", VSF_SERVER_ADDRESS, SEND_EMAIL_NOTI_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:email forKey:@"email"];
    
    [sendEmailNotiReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}

#pragma mark - Private Methods

- (void)receiveSendEmailNotificationServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFResponseEntity *respInfo = [[VSFResponseEntity alloc] init];
        respInfo.success = [responseData valueForKey:@"success"];
        respInfo.message = [responseData valueForKey:@"message"];
        
        [self.delegate setSendEmailNotificationResult:respInfo];
        [respInfo release];
    } else {
        NSLog(@"send email notification request failed.");
    }
}

@end
