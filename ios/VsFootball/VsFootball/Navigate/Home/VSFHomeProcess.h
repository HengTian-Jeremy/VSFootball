//
//  VSFHomeProcess.h
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;

@interface VSFHomeProcess : NSObject {
    VSFNetwork *getGameReq;
}

- (void)getGame;

@end
