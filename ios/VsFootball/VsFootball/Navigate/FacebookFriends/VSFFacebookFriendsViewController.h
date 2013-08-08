//
//  VSFFacebookFriendsViewController.h
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSFChineseBookAddress.h"

@interface VSFFacebookFriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    UISearchBar *searchFriendsSearchBar;
    UITableView *friendsTableView;
    UISearchDisplayController *searchDisplayController;
    
    NSArray *friendsDataArray;
    NSMutableArray *friendsNameArray;
    NSMutableArray *filteredArray;  // searchArray
    
    NSArray *dataSourceArray;
    NSMutableArray *indexArray;
    
    NSMutableArray *keys;
    NSMutableDictionary *nameDic;
}

@end
