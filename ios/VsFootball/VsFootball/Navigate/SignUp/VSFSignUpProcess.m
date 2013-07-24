//
//  VSFSignUpProcess.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFSignUpProcess.h"

#import "VSFNetwork.h"
#import "VSFSignUpEntity.h"
#import "ASIFormDataRequest.h"
#import "VSFCommonDefine.h"
#import "VSFResponseEntity.h"
#import "JSONKit.h"

@interface VSFSignUpProcess ()

@property (nonatomic, retain) VSFNetwork *signUpReq;

- (void)receiveSignUpServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFSignUpProcess

- (id)init
{
    self = [super init];
    if (self) {
        _signUpReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveSignUpServerData:status:)];
    }
    return self;
}

- (void)signUp:(VSFSignUpEntity *)entity
{
    NSURL *url = [NSURL URLWithString:SIGNUP_URL];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:entity.email forKey:@"email"];
    [asiReq setPostValue:entity.password forKey:@"password"];
    [asiReq setPostValue:entity.firstname forKey:@"firstname"];
    [asiReq setPostValue:entity.lastname forKey:@"lastname"];
    
    [self.signUpReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}

#pragma mark - Private Methods

- (void)receiveSignUpServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFResponseEntity *respEntity = [[VSFResponseEntity alloc] init];
        respEntity.success = [responseData valueForKey:@"success"];
        respEntity.message = [responseData valueForKey:@"message"];
        respEntity.guid = [responseData valueForKey:@"guid"];
        
        [self.delegate setSignUpResult:respEntity];
        [respEntity release];
    } else {
        NSLog(@"sign up request failed.");
    }
}

@end
