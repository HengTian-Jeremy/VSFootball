//
//  VSFNavigationController.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFNavigationController.h"

@interface VSFNavigationController ()

@end

@implementation VSFNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
                                       Duration:(float)Duration
                                           type:(UIViewAnimationTransition )type
{
    [UIView beginAnimations:nil context:NULL];
    
    if (animated) {
        if(type == UIViewAnimationTransitionNone) {
            [UIView setAnimationDuration: 0.5];
            [UIView setAnimationTransition:UIViewAnimationTransitionNone
                                   forView:self.view cache:NO];
        } else {
            [UIView setAnimationDuration: Duration];
            [UIView setAnimationTransition:type
                                   forView:self.view cache:NO];
        }
    }
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    [UIView commitAnimations];
    
    return viewController;
}

- (void)pushViewController:(UIViewController *)viewController
                  Duration:(float)Duration
                      type:(UIViewAnimationTransition )type
                  animated:(BOOL)animated
{
    [UIView beginAnimations:nil context:NULL];
    
    if (animated) {
        if(type == UIViewAnimationTransitionNone) {
            [UIView setAnimationDuration: 0.5];
            [UIView setAnimationTransition:UIViewAnimationTransitionNone
                                   forView:self.view cache:NO];
        } else {
            [UIView setAnimationDuration: Duration];
            [UIView setAnimationTransition:type
                                   forView:self.view cache:NO];
        }
        
    }
    [super pushViewController:viewController animated:animated];
    [UIView commitAnimations];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
                                    Duration:(float)Duration
                                        type:(UIViewAnimationTransition )type

{
    [UIView beginAnimations:nil context:NULL];
    
    if (animated) {
        if(type == UIViewAnimationTransitionNone) {
            [UIView setAnimationDuration: 0.5];
            [UIView setAnimationTransition:UIViewAnimationTransitionNone
                                   forView:self.view cache:NO];
        } else {
            [UIView setAnimationDuration: Duration];
            [UIView setAnimationTransition:type
                                   forView:self.view cache:NO];
        }
        
    }
    NSArray *viewControllerArray = [super popToRootViewControllerAnimated:animated];
    
    [UIView commitAnimations];
    
    return viewControllerArray;
    
}


@end
