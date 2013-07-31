//
//  VSFScoreboardView.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-25.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFScoreboardView.h"
#import "VSFScoreView.h"

#define SCOREBOARD_X 0
#define SCOREBOARD_Y -80
#define SCOREBOARD_W 320
#define SCOREBOARD_H 100
// Score view
#define SCOREVIEW_Y 0.25
#define SCOREVIEW_W 0.1
#define SCOREVIEW_H 0.68
#define HOME_SCOREVIEW_TENS_X 0.02
#define HOME_SCOREVIEW_UNITS_X 0.12
#define AWAY_SCOREVIEW_TENS_X 0.78
#define AWAY_SCOREVIEW_UNITS_X 0.88
// Time view
#define TIME_SCOREVIEW_Y 0.1
#define TIME_SCOREVIEW_W 0.05
#define TIME_SCOREVIEW_H 0.35
#define HOURS_SCOREVIEW_TENS_X 0.4
#define HOURS_SCOREVIEW_UNITS_X 0.45
#define MINUTES_SCOREVIEW_TENS_X 0.55
#define MINUTES_SCOREVIEW_UNITS_X 0.6
// Action view
#define ACTION_SCOREVIEW_Y 0.55
#define ACTION_SCOREVIEW_W 0.05
#define ACTION_SCOREVIEW_H 0.35
#define DOWN_SCOREVIEW_TENS_X 0.3
#define DOWN_SCOREVIEW_UNITS_X 0.35
#define TOGO_SCOREVIEW_TENS_X 0.45
#define TOGO_SCOREVIEW_UNITS_X 0.5
#define BO_SCOREVIEW_TENS_X 0.6
#define BO_SCOREVIEW_UNITS_X 0.65
// Home label
#define HOME_LABEL_X 0.02
#define HOME_LABEL_Y 0.02
#define HOME_LABEL_W 0.2
#define HOME_LABEL_H 0.28
#define HOME_LABEL_FONTSIZE 14.
// Away label
#define AWAY_LABEL_X 0.78
#define AWAY_LABEL_Y 0.02
#define AWAY_LABEL_W 0.2
#define AWAY_LABEL_H 0.28
#define AWAY_LABEL_FONTSIZE 14.
// Down label
#define DOWN_LABEL_X 0.3
#define DOWN_LABEL_Y 0.46
#define DOWN_LABEL_W 0.1
#define DOWN_LABEL_H 0.09
#define DOWN_LABEL_FONTSIZE 8.
// TO GO label
#define TOGO_LABEL_X 0.45
#define TOGO_LABEL_Y 0.46
#define TOGO_LABEL_W 0.1
#define TOGO_LABEL_H 0.09
#define TOGO_LABEL_FONTSIZE 8.
// B.O. label
#define BO_LABEL_X 0.6
#define BO_LABEL_Y 0.46
#define BO_LABEL_W 0.1
#define BO_LABEL_H 0.09
#define BO_LABEL_FONTSIZE 8.
// Time separator label
#define TIME_SEPARATOR_LABEL_X 0.5
#define TIME_SEPARATOR_LABEL_Y 0.1
#define TIME_SEPARATOR_LABEL_W 0.05
#define TIME_SEPARATOR_LABEL_H 0.35
#define TIME_SEPARATOR_LABEL_FONTSIZE 8.

static VSFScoreboardView *scoreboardView;

@interface VSFScoreboardView ()
{
    BOOL isPullDown;
}

- (void)singleTap:(id)sender;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

@end

@implementation VSFScoreboardView
@synthesize delegate;

+ (VSFScoreboardView *)getScoreboardView
{
    @synchronized([VSFScoreboardView class]) {
        if(!scoreboardView) {
            scoreboardView = [[self alloc] init];
        }
        return  scoreboardView;
    }
    return nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        isPullDown = NO;
        // add single tap gesture
        UITapGestureRecognizer *singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleRecognizer];
        
        // add pan gesture
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:panRecognizer];
        
        self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)addHomeScore:(int)score
{
    VSFScoreView *tensScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * HOME_SCOREVIEW_TENS_X, self.frame.size.height * SCOREVIEW_Y, self.frame.size.width * SCOREVIEW_W, self.frame.size.height * SCOREVIEW_H)];
    if (score / 10 != 0) {
        [tensScoreView createScoreArray:score / 10];
    }
    [tensScoreView createScoreView];
    [self addSubview:tensScoreView];
    
    VSFScoreView *unitsScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * HOME_SCOREVIEW_UNITS_X, self.frame.size.height * SCOREVIEW_Y, self.frame.size.width * SCOREVIEW_W, self.frame.size.height * SCOREVIEW_H)];
    [unitsScoreView createScoreArray:score % 10];
    [unitsScoreView createScoreView];
    [self addSubview:unitsScoreView];
}

- (void)addAwayScore:(int)score
{
    VSFScoreView *tensScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * AWAY_SCOREVIEW_TENS_X, self.frame.size.height * SCOREVIEW_Y, self.frame.size.width * SCOREVIEW_W, self.frame.size.height * SCOREVIEW_H)];
    if (score / 10 != 0) {
        [tensScoreView createScoreArray:score / 10];
    }
    [tensScoreView createScoreView];
    [self addSubview:tensScoreView];
    
    VSFScoreView *unitsScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * AWAY_SCOREVIEW_UNITS_X, self.frame.size.height * SCOREVIEW_Y, self.frame.size.width * SCOREVIEW_W, self.frame.size.height * SCOREVIEW_H)];
    [unitsScoreView createScoreArray:score % 10];
    [unitsScoreView createScoreView];
    [self addSubview:unitsScoreView];
}

- (void)addPlayTime:(NSString *)time
{
    NSArray *timeArray = [time componentsSeparatedByString:@":"];
    int hour = [[timeArray objectAtIndex:0] intValue];
    int minute = [[timeArray objectAtIndex:1] intValue];
    
    VSFScoreView *hoursTensScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * HOURS_SCOREVIEW_TENS_X, self.frame.size.height * TIME_SCOREVIEW_Y, self.frame.size.width * TIME_SCOREVIEW_W, self.frame.size.height * TIME_SCOREVIEW_H)];
    if (hour / 10 != 0) {
        [hoursTensScoreView createScoreArray:hour / 10];
    }
    [hoursTensScoreView createScoreView];
    [self addSubview:hoursTensScoreView];
    
    VSFScoreView *hoursUnitsScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * HOURS_SCOREVIEW_UNITS_X, self.frame.size.height * TIME_SCOREVIEW_Y, self.frame.size.width * TIME_SCOREVIEW_W, self.frame.size.height * TIME_SCOREVIEW_H)];
    [hoursUnitsScoreView createScoreArray:hour % 10];
    [hoursUnitsScoreView createScoreView];
    [self addSubview:hoursUnitsScoreView];
    
    VSFScoreView *minutesTensScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * MINUTES_SCOREVIEW_TENS_X, self.frame.size.height * TIME_SCOREVIEW_Y, self.frame.size.width * TIME_SCOREVIEW_W, self.frame.size.height * TIME_SCOREVIEW_H)];
    if (minute / 10 != 0) {
        [minutesTensScoreView createScoreArray:minute / 10];
    }
    [minutesTensScoreView createScoreView];
    [self addSubview:minutesTensScoreView];
    
    VSFScoreView *minutesUnitsScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * MINUTES_SCOREVIEW_UNITS_X, self.frame.size.height * TIME_SCOREVIEW_Y, self.frame.size.width * TIME_SCOREVIEW_W, self.frame.size.height * TIME_SCOREVIEW_H)];
    [minutesUnitsScoreView createScoreArray:minute % 10];
    [minutesUnitsScoreView createScoreView];
    [self addSubview:minutesUnitsScoreView];
}

- (void)addActionNumber:(int)down toGo:(int)toGo bo:(int)bo
{
    VSFScoreView *downTensScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * DOWN_SCOREVIEW_TENS_X, self.frame.size.height * ACTION_SCOREVIEW_Y, self.frame.size.width * ACTION_SCOREVIEW_W, self.frame.size.height * ACTION_SCOREVIEW_H)];
    if (down / 10 != 0) {
        [downTensScoreView createScoreArray:down / 10];
    }
    [downTensScoreView createScoreView];
    [self addSubview:downTensScoreView];
    
    VSFScoreView *downUnitsScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * DOWN_SCOREVIEW_UNITS_X, self.frame.size.height * ACTION_SCOREVIEW_Y, self.frame.size.width * ACTION_SCOREVIEW_W, self.frame.size.height * ACTION_SCOREVIEW_H)];
    [downUnitsScoreView createScoreArray:down % 10];
    [downUnitsScoreView createScoreView];
    [self addSubview:downUnitsScoreView];
    
    VSFScoreView *togoTensScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * TOGO_SCOREVIEW_TENS_X, self.frame.size.height * ACTION_SCOREVIEW_Y, self.frame.size.width * ACTION_SCOREVIEW_W, self.frame.size.height * ACTION_SCOREVIEW_H)];
    if (toGo / 10 != 0) {
        [togoTensScoreView createScoreArray:toGo / 10];
    }
    [togoTensScoreView createScoreView];
    [self addSubview:togoTensScoreView];
    
    VSFScoreView *togoUnitsScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * TOGO_SCOREVIEW_UNITS_X, self.frame.size.height * ACTION_SCOREVIEW_Y, self.frame.size.width * ACTION_SCOREVIEW_W, self.frame.size.height * ACTION_SCOREVIEW_H)];
    [togoUnitsScoreView createScoreArray:toGo % 10];
    [togoUnitsScoreView createScoreView];
    [self addSubview:togoUnitsScoreView];
    
    VSFScoreView *boTensScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * BO_SCOREVIEW_TENS_X, self.frame.size.height * ACTION_SCOREVIEW_Y, self.frame.size.width * ACTION_SCOREVIEW_W, self.frame.size.height * ACTION_SCOREVIEW_H)];
    if (bo / 10 != 0) {
        [boTensScoreView createScoreArray:bo / 10];
    }
    [boTensScoreView createScoreView];
    [self addSubview:boTensScoreView];
    
    VSFScoreView *boUnitsScoreView = [[VSFScoreView alloc] initWithFrame:CGRectMake(self.frame.size.width * BO_SCOREVIEW_UNITS_X, self.frame.size.height * ACTION_SCOREVIEW_Y, self.frame.size.width * ACTION_SCOREVIEW_W, self.frame.size.height * ACTION_SCOREVIEW_H)];
    [boUnitsScoreView createScoreArray:bo % 10];
    [boUnitsScoreView createScoreView];
    [self addSubview:boUnitsScoreView];
}

- (void)addLabel
{
    homeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * HOME_LABEL_X, self.frame.size.height * HOME_LABEL_Y, self.frame.size.width * HOME_LABEL_W, self.frame.size.height * HOME_LABEL_H)];
    homeLabel.text = @"HOME";
    homeLabel.textAlignment = NSTextAlignmentCenter;
    homeLabel.textColor = [UIColor whiteColor];
    homeLabel.font = [UIFont fontWithName:@"Arial" size:HOME_LABEL_FONTSIZE];
    homeLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:homeLabel];
    
    awayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * AWAY_LABEL_X, self.frame.size.height * AWAY_LABEL_Y, self.frame.size.width * AWAY_LABEL_W, self.frame.size.height * AWAY_LABEL_H)];
    awayLabel.text = @"AWAY";
    awayLabel.textAlignment = NSTextAlignmentCenter;
    awayLabel.textColor = [UIColor whiteColor];
    awayLabel.font = [UIFont fontWithName:@"Arial" size:AWAY_LABEL_FONTSIZE];
    awayLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:awayLabel];
    
    downLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * DOWN_LABEL_X, self.frame.size.height * DOWN_LABEL_Y, self.frame.size.width * DOWN_LABEL_W, self.frame.size.height * DOWN_LABEL_H)];
    downLabel.text = @"DOWN";
    downLabel.textAlignment = NSTextAlignmentCenter;
    downLabel.textColor = [UIColor whiteColor];
    downLabel.font = [UIFont fontWithName:@"Arial" size:DOWN_LABEL_FONTSIZE];
    downLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:downLabel];
    
    togoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * TOGO_LABEL_X, self.frame.size.height * TOGO_LABEL_Y, self.frame.size.width * TOGO_LABEL_W, self.frame.size.height * TOGO_LABEL_H)];
    togoLabel.text = @"TO GO";
    togoLabel.textAlignment = NSTextAlignmentCenter;
    togoLabel.textColor = [UIColor whiteColor];
    togoLabel.font = [UIFont fontWithName:@"Arial" size:TOGO_LABEL_FONTSIZE];
    togoLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:togoLabel];
    
    boLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * BO_LABEL_X, self.frame.size.height * BO_LABEL_Y, self.frame.size.width * BO_LABEL_W, self.frame.size.height * BO_LABEL_H)];
    boLabel.text = @"B.O.";
    boLabel.textAlignment = NSTextAlignmentCenter;
    boLabel.textColor = [UIColor whiteColor];
    boLabel.font = [UIFont fontWithName:@"Arial" size:BO_LABEL_FONTSIZE];
    boLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:boLabel];
    
    timeSeparatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * TIME_SEPARATOR_LABEL_X, self.frame.size.height * TIME_SEPARATOR_LABEL_Y, self.frame.size.width * TIME_SEPARATOR_LABEL_W, self.frame.size.height * TIME_SEPARATOR_LABEL_H)];
    timeSeparatorLabel.text = @":";
    timeSeparatorLabel.textAlignment = NSTextAlignmentCenter;
    timeSeparatorLabel.textColor = [UIColor whiteColor];
    timeSeparatorLabel.font = [UIFont fontWithName:@"Arial" size:TIME_SEPARATOR_LABEL_FONTSIZE];
    timeSeparatorLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:timeSeparatorLabel];
}

- (void)removeSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark - private methods
- (void)singleTap:(id)sender
{
    if (isPullDown) {
        isPullDown = NO;
        [self.delegate pullUpScoreboard];
    } else {
        isPullDown = YES;
        [self.delegate pullDownScoreboard];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (isPullDown) {
            isPullDown = NO;
            [self.delegate pullUpScoreboard];
        } else {
            isPullDown = YES;
            [self.delegate pullDownScoreboard];
        }
    }
}


@end