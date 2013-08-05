//
//  VSFEmailViewController.h
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSFEmailViewController : UIViewController <UITextFieldDelegate> {
    float prewMoveY;
    
    UILabel *messageLabel;
    UITextField *emailTextField;
    UIButton *cancelButton;
    UIButton *submitButton;
}

@end
