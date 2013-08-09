//
//  VSFGetGamesResponseEntity.h
//  VsFootball
//
//  Created by hjy on 8/7/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSFResponseEntity.h"

@interface VSFGetGamesResponseEntity : VSFResponseEntity 
    
@property (nonatomic, retain) NSMutableArray *gamesList;

@end

@interface VSFGamesEntity : NSObject

@property (nonatomic, retain) NSString *gameID;
@property (nonatomic, retain) NSString *player1;
@property (nonatomic, retain) NSString *player2;
@property (nonatomic, retain) NSString *player1TeamName;
@property (nonatomic, retain) NSString *player2TeamName;
@property (nonatomic, retain) NSString *outcome;
@property (nonatomic, retain) NSString *inviteAccepted;
@property (nonatomic, retain) NSMutableArray *turnsList;

@end

@interface VSFTurnsEntity : NSObject

@property (nonatomic, retain) NSString *gameID;
@property (nonatomic, retain) NSString *player1Id;
@property (nonatomic, retain) NSString *player2Id;
@property (nonatomic, retain) NSString *previousTurn;
@property (nonatomic, retain) NSString *yardLine;
@property (nonatomic, retain) NSString *down;
@property (nonatomic, retain) NSString *downDistance;
@property (nonatomic, retain) NSString *player1PlaySelected;
@property (nonatomic, retain) NSString *player2PlaySelected;
@property (nonatomic, retain) NSString *player1Role;
@property (nonatomic, retain) NSString *player2Role;
@property (nonatomic, retain) NSString *results;
@property (nonatomic, retain) NSString *playTime;
@property (nonatomic, retain) NSString *timeElaspedInGame;
@property (nonatomic, retain) NSString *currentPlayer1Score;
@property (nonatomic, retain) NSString *currentPlayer2Score;

@end
