//
//  VSFPlaySelectionViewController.h
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSFPlaySelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>{
    NSString *playSelectionType;
    UILabel *titleLabel;
    UIButton *backButton;
    UITableView *tacticsTableView;
    UIButton *runButton;
    UIButton *passButton;
    UIButton *specialTeamButton;
    UIImageView *boardImageView;
    
    NSMutableArray *runTacticsOffensiveArray;
    NSMutableArray *passTacticsOffensiveArray;
    NSMutableArray *specialTeamsTacticsOffensiveArray;
    NSMutableArray *runTacticsDefensiveArray;
    NSMutableArray *passTacticsDefensiveArray;
    NSMutableArray *specialTeamsTacticsDefensiveArray;
    NSMutableArray *dataSourceArray;
}

@end
