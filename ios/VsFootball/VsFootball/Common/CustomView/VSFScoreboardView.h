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
@interface VSFScoreboardView : UIView{
    UILabel *homeLabel;
    UILabel *awayLabel;
    UILabel *downLabel;
    UILabel *togoLabel;
    UILabel *boLabel;
    UILabel *timeSeparatorLabel;
}
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

/*!
 @method addHomeScore
 @abstract add Home Score View instance
 @discussion add Home Score View instance
 @param score user score
 @result void
 */
- (void)addHomeScore:(int)score;

/*!
 @method addAwayScore
 @abstract add Away Score View instance
 @discussion add Away Score View instance
 @param score opponent score
 @result void
 */
- (void)addAwayScore:(int)score;

/*!
 @method addPlayTime
 @abstract add Play Time View instance
 @discussion add Play Time View instance
 @param time
 @result void
 */
- (void)addPlayTime:(NSString *)time;

/*!
 @method addActionNumber
 @abstract add Action Number View instance
 @discussion add Action Number View instance
 @param times of down, to go, b.o.
 @result void
 */
- (void)addActionNumber:(int)down toGo:(int)toGo bo:(int)bo;

/*!
 @method removeSubviews
 @abstract remove subviews instance
 @discussion remove subviews instance
 @param NULL
 @result void
 */
- (void)removeSubviews;

/*!
 @method addLabel
 @abstract add label instance
 @discussion add label instance
 @param NULL
 @result void
 */
- (void)addLabel;

@end
