//
//  VSFGameSummaryView.h
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @protocol VSFGameSummaryViewDelegate
 
 @abstract GameSummary View Delegate
 
 @discussion GameSummary View Delegate
 */
@protocol VSFGameSummaryViewDelegate <NSObject>
/*!
 @method pullUpGameSummaryView
 @abstract pull up game summary view
 @discussion pull up game summary view
 @param NULL
 @result void
 */
- (void)pullUpGameSummaryView;

/*!
 @method pullDownGameSummaryView
 @abstract pull down game summary view
 @discussion pull down game summary view
 @param NULL
 @result void
 */
- (void)pullDownGameSummaryView;

/*!
 @method instantReplayClick
 @abstract click instant replay button
 @discussion click instant replay button
 @param NULL
 @result void
 */
- (void)instantReplay;

/*!
 @method chooseNextPlayClick
 @abstract click choose next play button
 @discussion click choose next play button
 @param NULL
 @result void
 */
- (void)chooseNextPlay;

@end

@interface VSFGameSummaryView : UIView{
    UIImageView *playImageView;
    UIButton *instantReplayButton;
    UIButton *chooseNextPlayButton;
}

@property (nonatomic, assign) id<VSFGameSummaryViewDelegate> delegate;

@end
