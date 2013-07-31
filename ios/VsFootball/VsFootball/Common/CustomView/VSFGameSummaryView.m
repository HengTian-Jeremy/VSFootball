//
//  VSFGameSummaryView.m
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFGameSummaryView.h"

//Instant replay button
#define INSTANT_REPLAY_BUTTON_X 20
#define INSTANT_REPLAY_BUTTON_Y 0.7
#define INSTANT_REPLAY_BUTTON_W 120
#define INSTANT_REPLAY_BUTTON_H 0.05
//Choose next play button
#define CHOOSE_NEXT_PLAY_BUTTON_X 180
#define CHOOSE_NEXT_PLAY_BUTTON_Y 0.7
#define CHOOSE_NEXT_PLAY_BUTTON_W 120
#define CHOOSE_NEXT_PLAY_BUTTON_H 0.05

@interface VSFGameSummaryView()

- (void)defaultInit;
- (void)clickOnInstantReplay;
- (void)clickOnChooseNextPlay;

@end

@implementation VSFGameSummaryView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code        
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
    
    instantReplayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    instantReplayButton.frame = CGRectMake(INSTANT_REPLAY_BUTTON_X, INSTANT_REPLAY_BUTTON_Y * self.frame.size.height, INSTANT_REPLAY_BUTTON_W, INSTANT_REPLAY_BUTTON_H * self.frame.size.height);
    [instantReplayButton setTitle:@"InstantReplay" forState:UIControlStateNormal];
    [instantReplayButton addTarget:self action:@selector(clickOnInstantReplay) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:instantReplayButton];
    
    chooseNextPlayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    chooseNextPlayButton.frame = CGRectMake(CHOOSE_NEXT_PLAY_BUTTON_X, CHOOSE_NEXT_PLAY_BUTTON_Y * self.frame.size.height, CHOOSE_NEXT_PLAY_BUTTON_W, CHOOSE_NEXT_PLAY_BUTTON_H * self.frame.size.height);
    [chooseNextPlayButton setTitle:@"Choose Next Play" forState:UIControlStateNormal];
    [chooseNextPlayButton addTarget:self action:@selector(clickOnChooseNextPlay) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chooseNextPlayButton];
}

- (void)clickOnInstantReplay
{
    [self.delegate instantReplay];
}

- (void)clickOnChooseNextPlay
{
    [self.delegate chooseNextPlay];
}

@end
