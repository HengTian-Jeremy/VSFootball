//
//  VSFSignUpProcess.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFSignUpProcess.h"

#import "VSFAppDelegate.h"
#import "VSFNetwork.h"
#import "VSFSignUpEntity.h"
#import "ASIFormDataRequest.h"
#import "VSFCommonDefine.h"
#import "VSFSignUpResponseEntity.h"
#import "JSONKit.h"

@interface VSFSignUpProcess ()

- (void)receiveSignUpServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFSignUpProcess

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        signUpReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveSignUpServerData:status:)];
    }
    return self;
}

- (void)signUp:(VSFSignUpEntity *)entity
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", VSF_SERVER_ADDRESS, SIGNUP_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:entity.email forKey:@"email"];
    [asiReq setPostValue:entity.password forKey:@"password"];
    [asiReq setPostValue:entity.firstname forKey:@"firstname"];
    [asiReq setPostValue:entity.lastname forKey:@"lastname"];
    [asiReq setPostValue:entity.platform forKey:@"platform"];
    
    [signUpReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}

#pragma mark - Private Methods

- (void)receiveSignUpServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFSignUpResponseEntity *respEntity = [[VSFSignUpResponseEntity alloc] init];
        respEntity.success = [responseData objectForKey:@"Success"];
        respEntity.message = [responseData objectForKey:@"Message"];
        respEntity.guid = [responseData objectForKey:@"Guid"];
        
        [self.delegate setSignUpResult:respEntity];
    } else {
        NSLog(@"sign up request failed.");
    }
}

@end
