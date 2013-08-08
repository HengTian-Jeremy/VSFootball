//
//  VSFFeedBackViewController.h
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSFFeedBackProcess.h"

@interface VSFFeedBackViewController : UIViewController <UITextViewDelegate, VSFFeedbackProcessDelegate>{
    UILabel *feedbackLabel;
    UITextView *feedbackTextView;
    UIButton *cancelButton;
    UIButton *submitButton;
    UILabel *thanksLabel;
    UIScrollView *scrollView;
    
    VSFFeedBackProcess *process;
}

@end
