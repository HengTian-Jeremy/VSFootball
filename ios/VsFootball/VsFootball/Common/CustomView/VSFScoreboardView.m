//
//  VSFScoreboardView.m
//  VsFootball
//
//  Created by Jessie Hu on 13-7-25.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFScoreboardView.h"

#define SCOREBOARD_X 0
#define SCOREBOARD_Y -80
#define SCOREBOARD_W 320
#define SCOREBOARD_H 100

static VSFScoreboardView *scoreboardView;

@interface VSFScoreboardView ()
{
    BOOL isPullDown;
}

- (void)singleTap:(id)sender;

@end

@implementation VSFScoreboardView

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
        
        UITapGestureRecognizer *singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleRecognizer];
        
        self.frame = CGRectMake(SCOREBOARD_X, SCOREBOARD_Y, SCOREBOARD_W, SCOREBOARD_H);
        self.backgroundColor = [UIColor lightGrayColor];
        UILabel *myLabel = [[UILabel alloc] init];
        myLabel.frame = CGRectMake(100, 20, 120, 60);
        myLabel.text = @"Scoreboard";
        myLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:myLabel];
        [myLabel release];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Private Methods

- (void)singleTap:(id)sender
{
    NSLog(@"single tap");
    
    if (isPullDown) {
        isPullDown = NO;
        [self.delegate pullUpScoreboard];
    } else {
        isPullDown = YES;
        [self.delegate pullDownScoreboard];
    }
}

@end