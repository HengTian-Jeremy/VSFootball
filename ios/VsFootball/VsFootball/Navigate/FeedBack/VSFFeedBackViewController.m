//
//  VSFFeedBackViewController.m
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFFeedBackViewController.h"
#import "VSFADBannerView.h"

// Feedback label
#define FEEDBACL_LABEL_X 25
#define FEEDBACL_LABEL_Y 0.04
#define FEEDBACL_LABEL_W 270
#define FEEDBACL_LABEL_H 0.15
// Feedback textview
#define FEEDBACK_TEXTVIEW_X 20
#define FEEDBACK_TEXTVIEW_Y 0.20
#define FEEDBACK_TEXTVIEW_W 280
#define FEEDBACK_TEXTVIEW_H 0.35
// Cancel button
#define CANCEL_BUTTON_X 30
#define CANCEL_BUTTON_Y 0.60
#define CANCEL_BUTTON_W 110
#define CANCEL_BUTTON_H 0.05
// Submit button
#define SUBMIT_BUTTON_X 180
#define SUBMIT_BUTTON_Y 0.60
#define SUBMIT_BUTTON_W 110
#define SUBMIT_BUTTON_H 0.05
// Thanks label
#define THANKS_LABEL_X 30
#define THANKS_LABEL_Y 0.67
#define THANKS_LABEL_W 260
#define THANKS_LABEL_H 0.05
// ScrollView for Main of ContentSize
#define SCROLL_VIEW_W 320
#define SCROLL_VIEW_H 1.5

@interface VSFFeedBackViewController ()

- (void)defaultInit;
- (void)clickOnCancel;
- (void)clickOnSubmit;

@end

@implementation VSFFeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self defaultInit];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self defaultInit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, self.view.bounds.size.height - 50, 320, 50);
    [self.view addSubview:[VSFADBannerView getAdBannerView]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [feedbackTextView resignFirstResponder];
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }    
    return YES;        
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [scrollView setScrollEnabled:YES];
    float moveY = 90;
    CGRect frame = scrollView.frame;
    frame.origin.y += moveY;
    frame.origin.x = 0;
    
    [scrollView scrollRectToVisible:frame animated:YES];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    CGRect frame = scrollView.frame;
    frame.origin.y = 0;
    frame.origin.x = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    [scrollView setScrollEnabled:NO];
    [textView resignFirstResponder];
    return YES;
}

#pragma mark - private methods
- (void)defaultInit
{
    self.title = @"Vs. Football";
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    [scrollView setContentSize:CGSizeMake(SCROLL_VIEW_W, SCROLL_VIEW_H * SCREEN_HEIGHT)];
    [scrollView setDelaysContentTouches:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollEnabled:NO];
    [self.view addSubview:scrollView];
    
    feedbackLabel = [[UILabel alloc] initWithFrame:CGRectMake(FEEDBACL_LABEL_X, FEEDBACL_LABEL_Y * SCREEN_HEIGHT, FEEDBACL_LABEL_W, FEEDBACL_LABEL_H * SCREEN_HEIGHT)];
    feedbackLabel.backgroundColor = [UIColor clearColor];
    feedbackLabel.numberOfLines = 0;
    feedbackLabel.textAlignment = NSTextAlignmentLeft;
    feedbackLabel.text = @"Let us know how we can\nimprove your experience with\nVs. Football:";
    [scrollView addSubview:feedbackLabel];
    
    feedbackTextView = [[UITextView alloc] initWithFrame:CGRectMake(FEEDBACK_TEXTVIEW_X, FEEDBACK_TEXTVIEW_Y * SCREEN_HEIGHT, FEEDBACK_TEXTVIEW_W, FEEDBACK_TEXTVIEW_H * SCREEN_HEIGHT)];
    feedbackTextView.delegate = self;
    feedbackTextView.returnKeyType = UIReturnKeyDone;
    feedbackTextView.backgroundColor = [UIColor whiteColor];
    [feedbackTextView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [feedbackTextView.layer setBorderWidth:1.0];
    feedbackTextView.keyboardType = UIKeyboardTypeDefault;
    feedbackTextView.scrollEnabled = YES;
    [scrollView addSubview:feedbackTextView];
    
    cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.frame = CGRectMake(CANCEL_BUTTON_X, CANCEL_BUTTON_Y * SCREEN_HEIGHT, CANCEL_BUTTON_W, CANCEL_BUTTON_H * SCREEN_HEIGHT);
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(clickOnCancel) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:cancelButton];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitButton.frame = CGRectMake(SUBMIT_BUTTON_X, SUBMIT_BUTTON_Y * SCREEN_HEIGHT, SUBMIT_BUTTON_W, SUBMIT_BUTTON_H * SCREEN_HEIGHT);
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickOnSubmit) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submitButton];
    
    thanksLabel = [[UILabel alloc] initWithFrame:CGRectMake(THANKS_LABEL_X, THANKS_LABEL_Y * SCREEN_HEIGHT, THANKS_LABEL_W, THANKS_LABEL_H * SCREEN_HEIGHT)];
    thanksLabel.backgroundColor = [UIColor clearColor];
    thanksLabel.textAlignment = NSTextAlignmentCenter;
    thanksLabel.textColor = [UIColor lightGrayColor];
    thanksLabel.text = @"Thank you for your feedback!";
    [scrollView addSubview:thanksLabel];

}

- (void)clickOnCancel
{
    feedbackTextView.text = @"";
}

- (void)clickOnSubmit
{
    
}




@end
