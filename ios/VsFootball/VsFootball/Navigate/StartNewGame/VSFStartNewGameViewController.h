//
//  VSFStartNewGameViewController.h
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class VSFStartNewGameViewController
 
 @abstract view controller for start new game
 
 @discussion view controller for start new game
 */
@interface VSFStartNewGameViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    UITableView *opponentTableView;
}

@end
