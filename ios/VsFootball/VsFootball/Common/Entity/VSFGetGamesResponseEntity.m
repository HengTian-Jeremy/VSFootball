//
//  VSFGetGamesResponseEntity.m
//  VsFootball
//
//  Created by hjy on 8/7/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFGetGamesResponseEntity.h"

@implementation VSFGetGamesResponseEntity
@synthesize gameID, player1, player2, player1TeamName, player2TeamName, outcome, previousTurn, yardLine, down, downDistance, player1PlaySelected, player2PlaySelected, player1Role, player2Role, results, playTime, timeElaspedInGame;

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
    }
    return self;
}

@end
