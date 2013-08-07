//
//  VSFFeedBackViewController.h
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSFFeedBackViewController : UIViewController <UITextViewDelegate>{
    UILabel *feedbackLabel;
    UITextView *feedbackTextView;
    UIButton *cancelButton;
    UIButton *submitButton;
    UILabel *thanksLabel;
    UIScrollView *scrollView;
}

@end
