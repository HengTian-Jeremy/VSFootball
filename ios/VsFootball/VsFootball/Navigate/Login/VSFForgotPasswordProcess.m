//
//  VSFForgotPasswordProcess.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFForgotPasswordProcess.h"

#import "VSFNetwork.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "VSFResponseEntity.h"
#import "VSFCommonDefine.h"

@interface VSFForgotPasswordProcess ()

@property (nonatomic, retain) VSFNetwork *forgotPasswordReq;

- (void)receiveForgotPasswordServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFForgotPasswordProcess

- (id)init
{
    self = [super init];
    if (self) {
        _forgotPasswordReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveForgotPasswordServerData:status:)];
    }
    return self;
}

- (void)dealloc
{
    [_forgotPasswordReq release];
    [super dealloc];
}

- (void)forgotPassword:(NSString *)email
{
    NSURL *url = [NSURL URLWithString:FORGOTPASSWORD_URL];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:email forKey:@"email"];
    
    [self.forgotPasswordReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}

#pragma mark - Private Methods

- (void)receiveForgotPasswordServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFResponseEntity *respInfo = [[VSFResponseEntity alloc] init];
        respInfo.success = [responseData valueForKey:@"success"];
        respInfo.message = [responseData valueForKey:@"message"];
        
        [self.delegate setForgotPasswordResult:respInfo];
        [respInfo release];
    } else {
        NSLog(@"forgotpassword request failed.");
    }
}

@end
