//
//  VSFHomeProcess.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFHomeProcess.h"

#import "VSFAppDelegate.h"
#import "VSFNetwork.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "VSFGetGamesResponseEntity.h"

@implementation VSFHomeProcess

@synthesize delegate;


- (id)init
{
    self = [super init];
    if (self) {
        getGameReq = [[VSFNetwork alloc] initWithTarget:self selector:@selector(receiveGetGameServerData:status:)];
    }
    return self;
}

- (void)getGameList
{
    NSString *guid = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUID"];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/games", VSF_SERVER_ADDRESS, guid];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [getGameReq startRequest:request activeIndicator:YES needInteract:YES parent:self.delegate];
//    [request setDelegate:self];
//    [request startAsynchronous];
}
/*
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSData* jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
    NSLog(@"%@", resultsDictionary);
    
    VSFGetGamesResponseEntity *respEntity = [[VSFGetGamesResponseEntity alloc] init];
    respEntity.success = [resultsDictionary objectForKey:@"Success"];
    respEntity.message = [resultsDictionary objectForKey:@"Message"];
    NSArray *games = [resultsDictionary objectForKey:@"Games"];
//    NSLog(@"%@", games);
    for (int i = 0; i< [games count]; ++i) {
        NSDictionary *gameDic = [games objectAtIndex:i];
//        NSLog(@"%@", gameDic);
    
        VSFGamesEntity *gamesEntity = [[VSFGamesEntity alloc] init];
        gamesEntity.gameID = [gameDic objectForKey:@"Gameid"];
        gamesEntity.player1 = [gameDic objectForKey:@"Player1"];
        gamesEntity.player2 = [gameDic objectForKey:@"Player2"];
        gamesEntity.player1TeamName = [gameDic objectForKey:@"Player1teamname"];
        gamesEntity.player2TeamName = [gameDic objectForKey:@"Player2teamname"];
        gamesEntity.outcome = [gameDic objectForKey:@"Outcome"];
        gamesEntity.inviteAccepted = [gameDic objectForKey:@"Inviteaccepted"];
        
        NSArray *turns = [gameDic objectForKey:@"Turns"];
        for (int j = 0; j < [turns count]; ++j) {
            NSDictionary *turnsDic = [turns objectAtIndex:j];
//            NSLog(@"%@", turnsDic);
            
            VSFTurnsEntity *turnsEntity = [[VSFTurnsEntity alloc] init];
            turnsEntity.gameID = [turnsDic objectForKey:@"id"];
            turnsEntity.player1Id = [turnsDic objectForKey:@"Player1id"];
            turnsEntity.player2Id = [turnsDic objectForKey:@"Player2id"];
            turnsEntity.previousTurn = [turnsDic objectForKey:@"Previousturn"];
            turnsEntity.yardLine = [turnsDic objectForKey:@"Yardline"];
            turnsEntity.down = [turnsDic objectForKey:@"Down"];
            turnsEntity.downDistance = [turnsDic objectForKey:@"Downdistance"];
            turnsEntity.previousTurn = [turnsDic objectForKey:@"Previousturn"];
            turnsEntity.player1PlaySelected = [turnsDic objectForKey:@"Player1playselected"];
            turnsEntity.player2PlaySelected = [turnsDic objectForKey:@"Player2playselected"];
            turnsEntity.player1Role = [turnsDic objectForKey:@"Player1role"];
            turnsEntity.player2Role = [turnsDic objectForKey:@"Player2role"];
            turnsEntity.results = [turnsDic objectForKey:@"Results"];
            turnsEntity.playTime = [turnsDic objectForKey:@"Playtime"];
            turnsEntity.timeElaspedInGame = [turnsDic objectForKey:@"Timeelaspedingame"];
            turnsEntity.currentPlayer1Score = [turnsDic objectForKey:@"Currentplayer1score"];
            turnsEntity.currentPlayer2Score = [turnsDic objectForKey:@"Currentplayer2score"];
            
            [gamesEntity.turnsList addObject:turnsEntity];
        }
        [respEntity.gamesList addObject:gamesEntity];
    }
    [self.delegate setGamesList:respEntity];
}*/

//- (void)requestFailed:(ASIHTTPRequest *)request
//{
//    NSError *error = [request error];
//    NSLog(@"error: %@", error);
//}

#pragma mark - Private Methods

- (void)receiveGetGameServerData:(NSString *)data status:(NSString *)status
{

    BOOL isYourTurn = YES;
    
    if ([status isEqualToString:@"0"]) {
        NSDictionary *resultsDictionary = [data objectFromJSONString];
        NSLog(@"%@", resultsDictionary);
        
        VSFGetGamesResponseEntity *respEntity = [[VSFGetGamesResponseEntity alloc] init];
        respEntity.success = [resultsDictionary objectForKey:@"Success"];
        respEntity.message = [resultsDictionary objectForKey:@"Message"];
        NSArray *games = [resultsDictionary objectForKey:@"Games"];
        NSLog(@"games: %@", games);
        if (games == [NSNull null]) {
            NSLog(@"games == [NSNull null]");
            return;
        }
        
        for (int i = 0; i< [games count]; ++i) {
            NSDictionary *gameDic = [games objectAtIndex:i];
            //        NSLog(@"%@", gameDic);
            
            VSFGamesEntity *gamesEntity = [[VSFGamesEntity alloc] init];
            gamesEntity.gameID = [gameDic objectForKey:@"Gameid"];
            gamesEntity.player1 = [gameDic objectForKey:@"Player1"];
            gamesEntity.player2 = [gameDic objectForKey:@"Player2"];
            gamesEntity.player1TeamName = [gameDic objectForKey:@"Player1teamname"];
            gamesEntity.player2TeamName = [gameDic objectForKey:@"Player2teamname"];
            gamesEntity.outcome = [gameDic objectForKey:@"Outcome"];
            gamesEntity.inviteAccepted = [gameDic objectForKey:@"Inviteaccepted"];
            
            NSArray *turns = [gameDic objectForKey:@"Turns"];
            for (int j = 0; j < [turns count]; ++j) {
                NSDictionary *turnsDic = [turns objectAtIndex:j];
                //            NSLog(@"%@", turnsDic);
                
                VSFTurnsEntity *turnsEntity = [[VSFTurnsEntity alloc] init];
                turnsEntity.gameID = [turnsDic objectForKey:@"id"];
                turnsEntity.player1Id = [turnsDic objectForKey:@"Player1id"];
                turnsEntity.player2Id = [turnsDic objectForKey:@"Player2id"];
                turnsEntity.previousTurn = [turnsDic objectForKey:@"Previousturn"];
                turnsEntity.yardLine = [turnsDic objectForKey:@"Yardline"];
                turnsEntity.down = [turnsDic objectForKey:@"Down"];
                turnsEntity.downDistance = [turnsDic objectForKey:@"Downdistance"];
                turnsEntity.previousTurn = [turnsDic objectForKey:@"Previousturn"];
                turnsEntity.player1PlaySelected = [turnsDic objectForKey:@"Player1playselected"];
                turnsEntity.player2PlaySelected = [turnsDic objectForKey:@"Player2playselected"];
                turnsEntity.player1Role = [turnsDic objectForKey:@"Player1role"];
                turnsEntity.player2Role = [turnsDic objectForKey:@"Player2role"];
                turnsEntity.results = [turnsDic objectForKey:@"Results"];
                turnsEntity.playTime = [turnsDic objectForKey:@"Playtime"];
                turnsEntity.timeElaspedInGame = [turnsDic objectForKey:@"Timeelaspedingame"];
                turnsEntity.currentPlayer1Score = [turnsDic objectForKey:@"Currentplayer1score"];
                turnsEntity.currentPlayer2Score = [turnsDic objectForKey:@"Currentplayer2score"];
                
                [gamesEntity.turnsList addObject:turnsEntity];
                
                if (j+1 == [turns count]) {
                    if ([turnsEntity.player1PlaySelected intValue] == 0
                        && [turnsEntity.player2PlaySelected intValue] == -1 ) {
                        //your turn
                        isYourTurn = YES;
                        
                    } else if ([turnsEntity.player1PlaySelected intValue] == -1
                               && [turnsEntity.player2PlaySelected intValue] == 0){
                        //their turn
                        isYourTurn = NO;
                    }
                }
            }
            [respEntity.gamesList addObject:gamesEntity];
            
            if (isYourTurn) {
                [respEntity.yourTurnGamesList addObject:gamesEntity];
//                NSLog(@"\n\n\n=YOUR TURN====>%@ VS %@\n\n\n",gamesEntity.player1TeamName, gamesEntity.player2TeamName);
                
            } else {
                [respEntity.theirTurnGamesList addObject:gamesEntity];
//                NSLog(@"\n\n\n=YOUR TURN====>%@ VS %@\n\n\n",gamesEntity.player1TeamName, gamesEntity.player2TeamName);
            }
            
            
            
        }
        [self.delegate setGamesList:respEntity];
    } else {
        NSLog(@"get gamelist request failed.");
    }
}

@end
