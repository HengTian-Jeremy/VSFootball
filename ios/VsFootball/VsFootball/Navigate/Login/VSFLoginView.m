//
//  VSFLoginView.m
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFLoginView.h"

@interface VSFLoginView ()

@property (nonatomic, retain) UITextField *usernameLabel;
@property (nonatomic, retain) UITextField *passwordLabel;
@property (nonatomic, retain) UITextField *usernameText;
@property (nonatomic, retain) UITextField *passwordText;
@property (nonatomic, retain) UIButton *signInButton;

@end

@implementation VSFLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        _usernameText = [[UITextField alloc] init];
        self.usernameText.frame = CGRectMake(USERNAMETEXT_X, USERNAMETEXT_Y, USERNAMETEXT_W, USERNAMETEXT_H);
        [self addSubview:self.usernameText];
    }
    return self;
}

- (void)dealloc
{
    [_usernameText release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
