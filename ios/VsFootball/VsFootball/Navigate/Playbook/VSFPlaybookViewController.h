//
//  VSFPlaybookViewController.h
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VSFViewController.h"

@interface VSFPlaybookViewController : VSFViewController <UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *playbooktableView;
}

@end
