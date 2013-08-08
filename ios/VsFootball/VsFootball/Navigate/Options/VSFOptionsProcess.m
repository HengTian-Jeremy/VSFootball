//
//  VSFOptionsProcess.m
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFOptionsProcess.h"
#import "VSFAppDelegate.h"
#import "VSFCommonDefine.h"
#import "ASIFormDataRequest.h"
#import "VSFCreateGameEntity.h"
#import "VSFCreateGameResponseEntity.h"
#import "VSFNetwork.h"
#import "JSONKit.h"
#import "VSFCommonDefine.h"

@interface VSFOptionsProcess ()

- (void)receiveCreateGameServerData:(NSString *)data status:(NSString *)status;

@end

@implementation VSFOptionsProcess

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        createGameReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveCreateGameServerData:status:)];
    }
    return self;
}

- (void)createGame:(VSFCreateGameEntity *)entity
{
    entity.inviteEmail = @"hanqunhu@hengtiansoft.com";
    entity.possession = @"Offensive";
    entity.teamName = @"team name";
    entity.playIDSelected = @"11";
    
    NSString *guid = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUID"];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@%@", VSF_SERVER_ADDRESS, guid, CREATEGAME_URL];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
    [asiReq setPostValue:entity.inviteEmail forKey:@"inviteEmail"];
    [asiReq setPostValue:entity.possession forKey:@"possession"];
    [asiReq setPostValue:entity.teamName forKey:@"teamName"];
    [asiReq setPostValue:entity.playIDSelected forKey:@"playIdSelected"];
    
    [createGameReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
    
//    NSString *guid = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUID"];
//    NSString *urlString = [NSString stringWithFormat:@"%@/%@%@", VSF_SERVER_ADDRESS, guid, RESIGNGAME_URL];
//    NSURL *url = [NSURL URLWithString:urlString];
//    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:url];
//    [asiReq setPostValue:@"123" forKey:@"GameId"];
//    
//    [createGameReq startRequest:asiReq activeIndicator:YES needInteract:YES parent:self.delegate];
}

#pragma mark - Private Methods

- (void)receiveCreateGameServerData:(NSString *)data status:(NSString *)status
{
    if ([status isEqualToString:@"0"]) {
        NSDictionary *responseData = [data objectFromJSONString];
        VSFCreateGameResponseEntity *respEntity = [[VSFCreateGameResponseEntity alloc] init];
        respEntity.success = [responseData objectForKey:@"Success"];
        respEntity.message = [responseData objectForKey:@"Message"];
        respEntity.gameID = [responseData objectForKey:@"GameId"];
        
        [self.delegate setCreateGameResult:respEntity];
    } else {
        NSLog(@"create game request failed.");
    }
}

@end
