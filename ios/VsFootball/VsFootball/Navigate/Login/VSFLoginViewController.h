//
//  VSFLoginViewController.h
//  VsFootball
//
//  Created by Jeremy on 13-7-23.
//  Copyright (c) 2013年 engagemobile. All rights reserved.
//

#import "VSFViewController.h"

#import "VSFLoginProcess.h"
#import "VSFForgotPasswordProcess.h"

@class DDMenuController;

/*!
    @class VSFLoginViewController
 
    @abstract view controller for login
 
    @discussion view controller for login
*/
@interface VSFLoginViewController : VSFViewController <VSFLoginProcessDelegate, VSFForgotPasswordProcessDelegate>{
//    DDMenuController *menuController;
}

@property (strong, nonatomic) DDMenuController *menuController;

@end
