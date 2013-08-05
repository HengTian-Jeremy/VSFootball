//
//  VSFFacebookFriendsViewController.h
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSFFacebookFriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    UISearchBar *searchFriendsSearchBar;
    UITableView *friendsTableView;
    UISearchDisplayController *searchDisplayController;
}

@end
