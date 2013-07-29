//
//  VSFHomeViewController.h
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VSFViewController.h"
#import "VSFScoreboardView.h"

@interface VSFHomeViewController : VSFViewController <VSFScoreboardViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    UIScrollView *stepInfoScrollView;
    UITableView *yourTurnTableView;
    UITableView *theirTurnTabelView;
    UITableView *resultTableView;
    
    NSArray *yourTurnArray;
    NSArray *theirTurnArray;
    NSArray *resultArray;
}

@end
