//
//  VSFAppDelegate.m
//  VsFootball
//
//  Created by Riddhiman Das on 7/22/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFAppDelegate.h"

#import "VSFLoginViewController.h"
#import "DDMenuController.h"
#import "VSFPlaybookViewController.h"
#import "VSFHomeViewController.h"
#import "VSFADBannerView.h"

@interface VSFAppDelegate ()

@end

@implementation VSFAppDelegate
@synthesize rootNavController;
@synthesize menuController;
@synthesize fbSession;
@synthesize guid;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:1.5];
    
    [Flurry startSession:@"TM46XNY9KC5QHFMR9QZS"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    VSFLoginViewController *loginController = [[VSFLoginViewController alloc] init];

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.guid = [userDefaults objectForKey:@"GUID"];
    
    if(guid != nil) {
        VSFHomeViewController *homeController = [[VSFHomeViewController alloc] init];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeController];
//        navController.navigationBarHidden = YES;
        DDMenuController *navDrawerController = [[DDMenuController alloc] initWithRootViewController:homeController];
        VSFPlaybookViewController *playbookController = [[VSFPlaybookViewController alloc] init];
        navDrawerController.leftViewController = playbookController;
        [VSFADBannerView getAdBannerView].frame = CGRectMake(0, SCREEN_HEIGHT - 20 - 44, 320, 50);
        [navDrawerController.view addSubview:[VSFADBannerView getAdBannerView]];
        rootNavController = [[VSFNavigationController alloc] initWithRootViewController:loginController];
        [rootNavController pushViewController:navDrawerController animated:NO];
    
    } else {
        rootNavController = [[VSFNavigationController alloc] initWithRootViewController:loginController];
    }
    rootNavController.navigationBarHidden = YES;
    self.window.rootViewController = rootNavController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.fbSession];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActiveWithSession:self.fbSession];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.fbSession close];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
