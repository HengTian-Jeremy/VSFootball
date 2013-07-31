//
//  VSFForgotPasswordProcess.m
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFForgotPasswordProcess.h"

#import "VSFAppDelegate.h"
#import "VSFNetwork.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "VSFCommonDefine.h"
#import "VSFForgotPasswordResponseEntity.h"

@interface VSFForgotPasswordProcess ()

- (void)receiveForgotPasswordServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFForgotPasswordProcess

- (id)init
{
    self = [super init];
    if (self) {
        forgotPasswordReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveForgotPasswordServerData:status:)];
    }
    return self;
}

- (void)forgotPassword:(NSString *)email
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", VSF_SERVER_ADDRESS, FORGOT_PWD_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:email forKey:@"email"];
    
    [forgotPasswordReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}

#pragma mark - Private Methods
- (void)receiveForgotPasswordServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFForgotPasswordResponseEntity *respInfo = [[VSFForgotPasswordResponseEntity alloc] init];
        respInfo.success = [responseData objectForKey:@"Success"];
        respInfo.message = [responseData objectForKey:@"Message"];
        
        [self.delegate setForgotPasswordResult:respInfo];
    } else {
        NSLog(@"forgot password request failed.");
    }
}

@end
