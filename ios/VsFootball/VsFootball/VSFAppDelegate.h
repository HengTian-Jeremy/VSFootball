//
//  VSFAppDelegate.h
//  VsFootball
//
//  Created by Riddhiman Das on 7/22/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSFNavigationController;

#define VSF_SERVER_ADDRESS @"http://vsf001.engagemobile.com"

@interface VSFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) VSFNavigationController *navController;

@end
