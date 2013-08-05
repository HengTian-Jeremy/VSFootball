//
//  VSFPlayComboViewController.h
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSFPlaySelectionViewDelegate.h"

@interface VSFPlayComboViewController : UIViewController <UIScrollViewDelegate>{
    UILabel *defensivePlayLabel;
    UILabel *offensivePlayLabel;
    UIScrollView *defensiveScrollView;
    UIScrollView *offensiveScrollView;
    UILabel *commentLabel;
    UIImageView *offensiveImageView;
    UIImageView *defensiveImageView;
    
    NSString *playType;
    NSString *tacticsName;
}

@end
