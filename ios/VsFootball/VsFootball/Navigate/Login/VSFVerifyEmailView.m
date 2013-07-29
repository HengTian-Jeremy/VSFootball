//
//  VSFVerifyEmailView.m
//  VsFootball
//
//  Created by hjy on 7/29/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFVerifyEmailView.h"
#import "VSFUtility.h"

// Title label
#define TITLE_LABEL_X 0
#define TITLE_LABEL_Y 0
#define TITLE_LABEL_W 320
#define TITLE_LABEL_H 0.15
#define TITLE_LABEL_FONT_SIZE 17.0f
// Email textfield
#define EMAIL_TEXTFILED_X 20
#define EMAIL_TEXTFILED_Y 0.2
#define EMAIL_TEXTFILED_W 380
#define EMAIL_TEXTFILED_H 0.2
// Send email button
#define SEND_EMAIL_BUTTON_X 50
#define SEND_EMAIL_BUTTON_Y 0.42
#define SEND_EMAIL_BUTTON_W 200
#define SEND_EMAIL_BUTTON_H 0.2

@interface VSFVerifyEmailView ()

- (void)defalutInit;
- (void)fadeIn;
- (void)fadeOut;
- (void)sendEmailButtonClick;

@end

@implementation VSFVerifyEmailView
@synthesize delegate, type;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self defalutInit];
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
- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self fadeIn];
}

- (void)dismiss
{
    [self fadeOut];
}


#pragma mark - private method
- (void)defalutInit
{
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 10.0f;
    self.clipsToBounds = TRUE;
    self.backgroundColor = [UIColor whiteColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE];
    titleLabel.backgroundColor = [UIColor colorWithRed:59./255.
                                                 green:89./255.
                                                  blue:152./255.
                                                 alpha:1.0f];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    CGFloat xWidth = self.bounds.size.width;
    titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
    titleLabel.frame = CGRectMake(0, 0, xWidth, self.bounds.size.height * TITLE_LABEL_H);
    [self addSubview:titleLabel];
    
    emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.bounds.size.height * EMAIL_TEXTFILED_Y, xWidth, self.bounds.size.height * EMAIL_TEXTFILED_H)];
    emailTextField.delegate = self;
    emailTextField.placeholder = @"Enter your email address";
    emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self addSubview:emailTextField];
    
    overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [overlayView addTarget:self
                    action:@selector(dismiss)
          forControlEvents:UIControlEventTouchUpInside];
    
    sendEmailButton = [[UIButton alloc] initWithFrame:CGRectMake(SEND_EMAIL_BUTTON_X, self.bounds.size.height * SEND_EMAIL_BUTTON_Y, SEND_EMAIL_BUTTON_W, self.bounds.size.height * SEND_EMAIL_BUTTON_H)];
    [sendEmailButton setBackgroundColor:[UIColor colorWithRed:59./255.
                                                        green:89./255.
                                                         blue:152./255.
                                                        alpha:1.0f]];
    [sendEmailButton setTitle:@"Send" forState:UIControlStateNormal];
    sendEmailButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [sendEmailButton addTarget:self action:@selector(sendEmailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendEmailButton];
    
}

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1., 1.);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)sendEmailButtonClick
{
    NSString *email = [emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *validateResult = [VSFUtility validateVerificationEmailInfo:email];
    if ([validateResult isEqualToString:@"SUCCESS"]) {
        if ([@"ForgotPassword" isEqualToString:type]) {
            [self.delegate sendEmailWhenForgotPassword:email];
        }else if ([@"ResendEmail" isEqualToString:type]){
            [self.delegate resendEmail:email];
        }
//        [self dismiss];
    }else{
            alertView = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                   message:validateResult
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
            [alertView show];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
