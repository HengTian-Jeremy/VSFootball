//
//  VSFContactsViewController.m
//  VsFootball
//
//  Created by hjy on 8/6/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFContactsViewController.h"
#import "VSFContacts.h"

@interface VSFContactsViewController () {
    NSMutableArray *contactsArray;
}

- (void)defaultInit;
- (void)friendsDivideIntoGroup;

@end

@implementation VSFContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self friendsDivideIntoGroup];        
        
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
    self.title = @"Contacts";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)friendsDivideIntoGroup
{
    [friendsNameArray removeAllObjects];
    
    VSFContacts *contacts = [[VSFContacts alloc] init];
    contactsArray  = contacts.contactsArray;
    for (int i = 0; i < contactsArray.count; i ++) {
        [friendsNameArray addObject:[[contactsArray objectAtIndex:i] name]];
    }
    
    for (int i = 0; i < [friendsNameArray count]; ++i) {
        char firstChar = changeChineseFirstLetter([[friendsNameArray objectAtIndex:i] characterAtIndex:0]);
        NSString *firstStr = [NSString stringWithFormat:@"%c", firstChar];
        if (![keys containsObject:[firstStr uppercaseString]]) {
            [keys addObject:[firstStr uppercaseString]];
        }
    }
    [keys sortUsingSelector:@selector(compare:)];
    
    for (NSString *sectionStr in keys) {
        NSMutableArray *rowSource = [[NSMutableArray alloc] init];
        for (NSString *charStr in friendsNameArray) {
            char firstChar = changeChineseFirstLetter([charStr characterAtIndex:0]);
            NSString *firstStr = [NSString stringWithFormat:@"%c", firstChar];
            if ([sectionStr isEqualToString:[firstStr uppercaseString]]) {
                [rowSource addObject:charStr];
            }
        }
        [nameDic setValue:rowSource forKey:sectionStr];
    }

}

@end
