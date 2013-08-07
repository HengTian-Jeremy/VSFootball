//
//  VSFOptionsProcess.h
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFCreateGameEntity;
@class VSFCreateGameResponseEntity;

@protocol VSFOptionsProcessDelegate <NSObject>

- (void)setCreateGameResult:(VSFCreateGameResponseEntity *)respEntity;

@end

@interface VSFOptionsProcess : NSObject {
    
    VSFNetwork *createGameReq;
}

@property (nonatomic, assign) id<VSFOptionsProcessDelegate> delegate;

- (void)createGame:(VSFCreateGameEntity *)entity;

@end
