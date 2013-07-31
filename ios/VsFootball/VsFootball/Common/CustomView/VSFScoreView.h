//
//  VSFScoreView.h
//  VsFootball
//
//  Created by hjy on 7/29/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class VSFScoreView
 
 @abstract Score view
 
 @discussion Score view
 */
@interface VSFScoreView : UIView{
    NSMutableArray *scoreArray;
}

- (void)createScoreArray:(int)scoreNumber;
- (void)createScoreView;

@end
