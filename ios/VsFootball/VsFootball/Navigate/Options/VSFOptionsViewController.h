//
//  VSFOptionsViewController.h
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSFOptionsProcess.h"
#import "VSFCreateGameEntity.h"

@interface VSFOptionsViewController : UIViewController <UITextFieldDelegate, VSFOptionsProcessDelegate> {
    float prewMoveY;
    
    UILabel *playerNameLabel;
    UILabel *playSelectionLabel;
    UILabel *orLabel;
    UILabel *noteLabel;
    UILabel *enterTeamNameLabel;
    UIButton *offenseButton;
    UIButton *defenseButton;
    UIButton *callFirstPlayButton;
    UITextField *teamNameTextField;
    
    VSFOptionsProcess *process;
    VSFCreateGameEntity *createGameEntity;
}


@end
