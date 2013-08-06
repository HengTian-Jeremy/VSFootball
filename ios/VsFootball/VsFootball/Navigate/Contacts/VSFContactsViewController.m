//
//  VSFContactsViewController.m
//  VsFootball
//
//  Created by hjy on 8/6/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFContactsViewController.h"

@interface VSFContactsViewController ()

- (void)defaultInit;

@end

@implementation VSFContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

#pragma mark - private methods
- (void)defaultInit
{
    UIBarButtonItem *backButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    self.title = @"Contacts";
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
