//
//  VSFPlayOutcome.m
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlayOutcome.h"

// Combo label
#define Combo_Label_X 0.2
#define Combo_Label_Y 0.2
#define Combo_Label_W 0.6
#define Combo_Label_H 0.6

@interface VSFPlayOutcome ()

- (void)defaultInit;

@end

@implementation VSFPlayOutcome

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
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
    
    comboLabel = [[UILabel alloc] initWithFrame:CGRectMake(Combo_Label_X * self.frame.size.width, Combo_Label_Y * self.frame.size.height, Combo_Label_W * self.frame.size.width, Combo_Label_H * self.frame.size.height)];
    comboLabel.backgroundColor = [UIColor clearColor];
    comboLabel.textAlignment = NSTextAlignmentCenter;
    comboLabel.numberOfLines = 0;
    comboLabel.text = @"Gain of 6 on\the play!\n\nNow 3rd and 4\non your own 44";
    [self addSubview:comboLabel];
}

@end
