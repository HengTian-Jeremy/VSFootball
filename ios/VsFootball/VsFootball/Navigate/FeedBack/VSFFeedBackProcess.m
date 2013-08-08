//
//  VSFFeedBackProcess.m
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFFeedBackProcess.h"

#import "VSFAppDelegate.h"
#import "VSFNetwork.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "VSFCommonDefine.h"
#import "VSFResponseEntity.h"

@interface VSFFeedBackProcess ()

- (void)receiveFeedbackServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFFeedBackProcess
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        feedbackRequest = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveFeedbackServerData:status:)];
    }
    return self;
}

- (void)sendFeedbackInformation:(NSString *)comment gameId:(NSNumber *)gameId screen:(NSString *)screen
{
    NSString *guid = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUID"];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@%@", VSF_SERVER_ADDRESS, guid, SEND_FEEDBACK_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:comment forKey:@"comment"];
    if([gameId isEqual:[NSNull null]] == NO && gameId != nil) {
        [asiReq setPostValue:gameId forKey:@"gameId"];
    }
    if([screen isEqual:[NSNull null]] == NO && gameId != nil) {
        [asiReq setPostValue:screen forKey:@"screen"];
    }
    
    [feedbackRequest startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}


#pragma mark - Private Methods

- (void)receiveFeedbackServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFResponseEntity *respInfo = [[VSFResponseEntity alloc] init];
        respInfo.success = [responseData objectForKey:@"Success"];
        respInfo.message = [responseData objectForKey:@"Message"];
        
        [self.delegate setFeedbackResult:respInfo];
    } else {
        [self.delegate setFeedbackResult:nil];
        NSLog(@"sign in request failed.");
    }
}


@end
