//
//  VSFHomeViewController.h
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VSFViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface VSFHomeViewController : VSFViewController <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate, UIScrollViewDelegate> {
    BOOL isReloading;
    
    UIScrollView *stepInfoScrollView;
    UITableView *yourTurnTableView;
    UITableView *theirTurnTabelView;
    UITableView *resultTableView;
    EGORefreshTableHeaderView *refreshHeaderView;
    
    NSArray *yourTurnArray;
    NSArray *theirTurnArray;
    NSArray *resultArray;
}

@end
