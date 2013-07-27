//
//  VSFNavigationController.h
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
    @class VSFNavigationController
 
    @abstract custom NavigationController for animation
 
    @discussion custom NavigationController for animation
*/
@interface VSFNavigationController : UINavigationController

/*!
    @method popViewControllerAnimated:Duration:type
    @abstract popViewController
    @discussion pop current ViewController using duration and animation type
    @param animated if use animation
    @param Duration  animation Duration (s)
    @param type animation type
    @result UIViewController*
*/
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
                                       Duration:(float)Duration
                                           type:(UIViewAnimationTransition )type;

/*!
    @method pushViewController:Duration:type:animated
    @abstract pushViewController
    @discussion push a ViewController using duration and animation type
    @param animated if use animation
    @param Duration  animation Duration (s)
    @param type animation type
    @param viewController vc object to push
    @result void
*/
- (void)pushViewController:(UIViewController *)viewController
                  Duration:(float)Duration
                      type:(UIViewAnimationTransition )type
                  animated:(BOOL)animated;

/*!
    @method popToRootViewControllerAnimated:Duration:type
    @abstract popViewController
    @discussion pop current ViewController using duration and animation type
    @param animated if use animation
    @param Duration  animation Duration (s)
    @param type animation type
    @result NSArray * all poped vc objects
*/
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
                                    Duration:(float)Duration
                                        type:(UIViewAnimationTransition )type;


@end
