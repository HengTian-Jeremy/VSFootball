//
//  VSFScoreboardView.h
//  VsFootball
//
//  Created by Jessie Hu on 13-7-25.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VSFScoreboardViewDelegate <NSObject>

@optional

- (void)pullUpScoreboard;
- (void)pullDownScoreboard;

@end

@interface VSFScoreboardView : UIView

@property (nonatomic, assign) id<VSFScoreboardViewDelegate> delegate;

+ (VSFScoreboardView *)getScoreboardView;

@end
