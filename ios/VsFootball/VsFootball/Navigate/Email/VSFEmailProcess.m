//
//  VSFEmailProcess.m
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFEmailProcess.h"

#import "VSFAppDelegate.h"
#import "VSFNetwork.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "VSFInviteToJoinEntity.h"

@interface VSFEmailProcess ()

- (void)receiveInviteToJoinServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFEmailProcess
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        inviteByEmailReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveInviteToJoinServerData:status:)];
    }
    return self;
}

- (void)inviteByEmail:(NSString *)email
{
    NSString *guid = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUID"];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/invite/email", VSF_SERVER_ADDRESS, guid];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:email forKey:@"EmailAddress"];
    
    [inviteByEmailReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}

#pragma mark - Private Methods
- (void)receiveInviteToJoinServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFInviteToJoinEntity *respInfo = [[VSFInviteToJoinEntity alloc] init];
        NSLog(@"response=%@", respInfo.success);
        respInfo.success = [responseData objectForKey:@"Success"];
        respInfo.message = [responseData objectForKey:@"Message"];
        
        [self.delegate setInviteByEmailResult:respInfo];
    } else {
        NSLog(@"invite by email request failed.");
    }
}

@end
