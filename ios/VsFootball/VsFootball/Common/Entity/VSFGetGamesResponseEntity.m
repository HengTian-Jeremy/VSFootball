//
//  VSFGetGamesResponseEntity.m
//  VsFootball
//
//  Created by hjy on 8/7/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFGetGamesResponseEntity.h"

@implementation VSFGetGamesResponseEntity
@synthesize gamesList;
@synthesize yourTurnGamesList;
@synthesize theirTurnGamesList;

- (id)init
{
    self = [super init];
    if (self) {
        gamesList = [[NSMutableArray alloc] init];
        yourTurnGamesList = [[NSMutableArray alloc] init];
        theirTurnGamesList = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

@implementation VSFGamesEntity
@synthesize gameID, player1, player2, player1TeamName, player2TeamName, outcome, inviteAccepted, turnsList;

- (id)init
{
    self = [super init];
    if (self) {
        gameID = [[NSString alloc] init];
        player1 = [[NSString alloc] init];
        player2 = [[NSString alloc] init];
        player1TeamName = [[NSString alloc] init];
        player2TeamName = [[NSString alloc] init];
        outcome = [[NSString alloc] init];
        inviteAccepted = [[NSString alloc] init];
        turnsList = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

@implementation VSFTurnsEntity
@synthesize gameID, player1Id, player2Id, previousTurn, yardLine, down, downDistance, player1PlaySelected, player2PlaySelected, player1Role, player2Role, results, playTime, timeElaspedInGame, currentPlayer1Score, currentPlayer2Score;

- (id)init
{
    self = [super init];
    if (self) {
        gameID = [[NSString alloc] init];
        player1Id = [[NSString alloc] init];
        player2Id = [[NSString alloc] init];
        previousTurn = [[NSString alloc] init];
        yardLine = [[NSString alloc] init];
        down = [[NSString alloc] init];
        downDistance = [[NSString alloc] init];
        player1PlaySelected = [[NSString alloc] init];
        player2PlaySelected = [[NSString alloc] init];
        player1Role = [[NSString alloc] init];
        player2Role = [[NSString alloc] init];
        results = [[NSString alloc] init];
        playTime = [[NSString alloc] init];
        timeElaspedInGame = [[NSString alloc] init];
        currentPlayer1Score = [[NSString alloc] init];
        currentPlayer2Score = [[NSString alloc] init];
    }
    return self;
}

@end
