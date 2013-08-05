//
//  VSFAppDelegate.h
//  VsFootball
//
//  Created by Riddhiman Das on 7/22/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#define VSF_SERVER_ADDRESS @"http://vsf001.engagemobile.com"

@class DDMenuController;

@interface VSFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) FBSession *fbSession;

@end
