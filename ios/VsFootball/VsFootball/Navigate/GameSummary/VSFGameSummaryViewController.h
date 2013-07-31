//
//  VSFGameSummaryViewController.h
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSFScoreboardView.h"
#import "VSFGameSummaryView.h"

@interface VSFGameSummaryViewController : UIViewController<VSFScoreboardViewDelegate, VSFGameSummaryViewDelegate>{
    VSFGameSummaryView *gameSummaryView;
}

@end
