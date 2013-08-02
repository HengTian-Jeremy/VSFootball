//
//  VSFIndicatorView.m
//  VsFootball
//
//  Created by Habe on 13-8-2.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFIndicatorView.h"
#define LOGINING_ACTIVITYINDICATOR_VIEW_X 100
#define LOGINING_ACTIVITYINDICATOR_VIEW_Y 0.25
#define LOGINING_ACTIVITYINDICATOR_VIEW_W 120
#define LOGINING_ACTIVITYINDICATOR_VIEW_H 0.25


@implementation VSFIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [ UIColor blackColor];
        self.alpha = 0.5;
        
        loginingIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        loginingIndicatorView.frame = CGRectMake(LOGINING_ACTIVITYINDICATOR_VIEW_X, SCREEN_HEIGHT * LOGINING_ACTIVITYINDICATOR_VIEW_Y, LOGINING_ACTIVITYINDICATOR_VIEW_W, SCREEN_HEIGHT * LOGINING_ACTIVITYINDICATOR_VIEW_H);
        [self addSubview:loginingIndicatorView];
        [loginingIndicatorView startAnimating];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)removeIndicator
{
    for (UIView *subviews in self.subviews) {
        [subviews removeFromSuperview];
    }
}

@end
