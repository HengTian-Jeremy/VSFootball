//
//  VSFCustomSegmentedControl.h
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VSFCustomSegmentedControl;
/*!
 @protocol VSFCustomSegmentedControlDelegate
 
 @abstract Custom SegmentedControl Delegate
 
 @discussion Custom SegmentedControl Delegate
 */
@protocol VSFCustomSegmentedControlDelegate <NSObject>

/*!
 @method buttonFor: atIndex
 @abstract segmented control
 @discussion return the clicked button in segmented control
 @param segmentedControl
 @param segmentIndex
 @result UIButton 
 */
- (UIButton*) buttonFor:(VSFCustomSegmentedControl *)segmentedControl atIndex:(NSUInteger)segmentIndex;

@optional
/*!
 @method touchUpInsideSegmentIndex
 @abstract touch up inside segment
 @discussion touch up inside segment
 @param segmentIndex
 @result void
 */
- (void) touchUpInsideSegmentIndex:(NSUInteger)segmentIndex;

/*!
 @method touchDownAtSegmentIndex
 @abstract touch down inside segment
 @discussion touch down inside segment
 @param segmentIndex
 @result void
 */
- (void) touchDownAtSegmentIndex:(NSUInteger)segmentIndex;

@end

/*!
 @class VSFCustomSegmentedControl
 
 @abstract custom SegmentedControl
 
 @discussion custom SegmentedControl
 */
@interface VSFCustomSegmentedControl : UIView{
    int segmentCount;
    NSMutableArray *buttons;
}

@property (nonatomic, assign) id<VSFCustomSegmentedControlDelegate> delegate;
@property (nonatomic, retain)  NSMutableArray *buttons;

@end
