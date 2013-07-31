//
//  VSFCustomSegmentedControl.m
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFCustomSegmentedControl.h" 

@interface VSFCustomSegmentedControl()

- (void)defaultInit;

@end

@implementation VSFCustomSegmentedControl
@synthesize delegate, buttons;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        segmentCount = self.buttons.count;
        self.buttons = [[NSMutableArray alloc] initWithCapacity:segmentCount];

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
    
}

@end
