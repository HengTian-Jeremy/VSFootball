//
//  VSFScoreboardView.h
//  VsFootball
//
//  Created by Jessie Hu on 13-7-25.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
    @protocol VSFScoreboardViewDelegate
 
    @abstract Scoreboard View Delegate
 
    @discussion Scoreboard View Delegate
*/
@protocol VSFScoreboardViewDelegate <NSObject>
@optional
/*!
    @method pullUpScoreboard
    @abstract pull up scoreboard view
    @discussion pull up scoreboard view
    @param NULL
    @result void
 */
- (void)pullUpScoreboard;

/*!
    @method pullDownScoreboard
    @abstract pull down scoreboard view
    @discussion pull down scoreboard view
    @param NULL
    @result void
*/
- (void)pullDownScoreboard;

@end

/*!
    @class VSFScoreboardView
 
    @abstract scoreboard view
 
    @discussion scoreboard view
*/
@interface VSFScoreboardView : UIView
// Response data target
@property (nonatomic, assign) id<VSFScoreboardViewDelegate> delegate;

/*!
    @method getScoreboardView
    @abstract get VSFScoreboardView instance
    @discussion get VSFScoreboardView instance
    @param NULL
    @result VSFScoreboardView instance
*/
+ (VSFScoreboardView *)getScoreboardView;

@end
