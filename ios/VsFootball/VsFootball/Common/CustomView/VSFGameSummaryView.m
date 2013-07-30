//
//  VSFGameSummaryView.m
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFGameSummaryView.h"

//Instant replay button
#define INSTANT_REPLAY_BUTTON_
#define INSTANT_REPLAY_BUTTON_
#define INSTANT_REPLAY_BUTTON_
#define INSTANT_REPLAY_BUTTON_
//Choose next play button
#define CHOOSE_NEXT_PLAY_BUTTON_
#define CHOOSE_NEXT_PLAY_BUTTON_
#define CHOOSE_NEXT_PLAY_BUTTON_
#define CHOOSE_NEXT_PLAY_BUTTON_

@interface VSFGameSummaryView(){
    BOOL isPullDown;
}

- (void)defaultInit;
- (void)singleTap:(id)sender;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

@end
@implementation VSFGameSummaryView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isPullDown = NO;
        // add single tap gesture
        UITapGestureRecognizer *singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleRecognizer];
        
        // add pan gesture
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:panRecognizer];
        
        // init UI
        [self defaultInit];
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

#pragma mark - private methods
- (void)defaultInit
{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)singleTap:(id)sender
{    
    if (isPullDown) {
        isPullDown = NO;
        [self.delegate pullUpGameSummaryView];
    } else {
        isPullDown = YES;
        [self.delegate pullDownGameSummaryView];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (isPullDown) {
            isPullDown = NO;
            [self.delegate pullUpGameSummaryView];
        } else {
            isPullDown = YES;
            [self.delegate pullDownGameSummaryView];
        }
    }
}


@end
