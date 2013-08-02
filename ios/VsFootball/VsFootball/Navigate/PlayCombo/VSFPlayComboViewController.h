//
//  VSFPlayComboViewController.h
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSFPlayComboViewController : UIViewController <UIScrollViewDelegate>{
    UILabel *defensivePlayLabel;
    UILabel *offensivePlayLabel;
    UIScrollView *defensiveScrollView;
    UIScrollView *offensiveScrollView;
    UILabel *commentLabel;
}

- (void)defaultInit;

@end
