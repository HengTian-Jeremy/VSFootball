//
//  VSFHomeProcess.h
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFGetGamesResponseEntity;
@class VSFTurnsEntity;

/*!
    @protocol VSFHomeProcessDelegate
 
    @abstract Home process delegate
 
    @discussion Home process delegate
*/
@protocol VSFHomeProcessDelegate <NSObject>

/*!
    @method setGamesList:
    @abstract set gamelist data to delegate
    @discussion set gamelist data to delegate
    @param respEntity VSFGetGamesResponseEntity Entity
    @result void
*/
- (void)setGamesList:(VSFGetGamesResponseEntity *)respEntity;

@end

/*!
    @class VSFHomeProcess
 
    @abstract Home processor
 
    @discussion Home processor
*/
@interface VSFHomeProcess : NSObject {
    VSFNetwork *getGameReq;
}
// Response data target
@property (nonatomic, assign) id<VSFHomeProcessDelegate> delegate;

/*!
    @method getGame
    @abstract get gamelist interface
    @discussion get gamelist interface
    @param NULL
    @result void
*/
- (void)getGameList;

@end
