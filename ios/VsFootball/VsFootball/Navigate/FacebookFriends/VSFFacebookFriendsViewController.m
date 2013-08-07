//
//  VSFFacebookFriendsViewController.m
//  VsFootball
//
//  Created by hjy on 8/5/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFFacebookFriendsViewController.h"
#import "VSFOptionsViewController.h"
#import "VSFFacebookFriends.h"
#import "VSFAppDelegate.h"
#import "VSFChineseBookAddress.h"

// Search friends searchbar
#define SEARCH_FRIENDS_SEARCHBAR_X 0
#define SEARCH_FRIENDS_SEARCHBAR_Y 0.0
#define SEARCH_FRIENDS_SEARCHBAR_W 320
#define SEARCH_FRIENDS_SEARCHBAR_H 0.07
// Friends tableview
#define FRIENDS_TABLEVIEW_X 0
#define FRIENDS_TABLEVIEW_Y 0.0
#define FRIENDS_TABLEVIEW_W 320
#define FRIENDS_TABLEVIEW_H 0.95

@interface VSFFacebookFriendsViewController () {
    NSArray *friendsDataArray;
    NSMutableArray *friendsNameArray;
    NSMutableArray *filteredArray;  // searchArray
    
    NSArray *dataSourceArray;
    NSMutableArray *indexArray;
    
    NSMutableArray *keys;
    NSMutableDictionary *nameDic;
}

- (void)defaultInit;
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;
- (void)friendsDivideIntoGroup;

@end

@implementation VSFFacebookFriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        friendsDataArray = [[NSArray alloc] initWithObjects:@"Pete Cashmore", @"John Gruber", @"Joe Hewitt", @"Tim O'Reilly", @"MG Siegler", @"Biz Stone", @"Evan Williams", @"Mark Zuckerberg", @"AAA 11", @"CCC 22", @"EEE 33", @"夏天 44", @"QQQ 55", @"FFF 666", @"菜小花 77", @"UUU 88",  nil];
//        friendsNameArray = [NSMutableArray arrayWithArray:friendsDataArray];
        
        filteredArray = [[NSMutableArray alloc] init];
        dataSourceArray = [[NSArray alloc] init];
        keys = [[NSMutableArray alloc] init];
        nameDic = [[NSMutableDictionary alloc] init];
        
        friendsDataArray = [[NSMutableArray alloc] initWithArray:[VSFFacebookFriends getFacebookFriends].friendsList];
        friendsNameArray = [NSMutableArray arrayWithCapacity:[friendsDataArray count]];
        for (NSDictionary<FBGraphUser>* friend in friendsDataArray) {
            [friendsNameArray addObject:friend.name];
        }
        
        // divide friendNameArray into group 
        [self friendsDivideIntoGroup];
        
        indexArray = [[NSMutableArray alloc] init];
        for(char c = 'A'; c <= 'Z'; c++ ){
            [indexArray addObject:[NSString stringWithFormat:@"%c", c]];
        }

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < -CGRectGetHeight(searchFriendsSearchBar.bounds)) {
        // Make sure the search bar is below the section index titles control when scrolling up
        searchFriendsSearchBar.layer.zPosition = 0; 
    } else {
        // Make sure the search bar is above the section headers when scrolling down
        searchFriendsSearchBar.layer.zPosition = 1;
    }
    
    CGRect searchBarFrame = searchFriendsSearchBar.frame;
    searchBarFrame.origin.y = MAX(scrollView.contentOffset.y, -CGRectGetHeight(searchBarFrame));
    
    searchFriendsSearchBar.frame = searchBarFrame;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([friendsNameArray count] > 0) {
        dataSourceArray = [nameDic objectForKey:[keys objectAtIndex:indexPath.section]];
    }else{
        dataSourceArray = filteredArray;
    }
    
    NSString *message = [NSString stringWithFormat:@"Would you like to start a game with %@", [dataSourceArray objectAtIndex: indexPath.row]];
    UIAlertView *confirmationAlertView = [[UIAlertView alloc] initWithTitle:@"Start Game" message:message delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    confirmationAlertView.tag = indexPath.row;
    [confirmationAlertView show];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if ([filteredArray count] > 0) {
        return [filteredArray count];
    } else {
        NSArray *sectionNameArray = [nameDic objectForKey:[keys objectAtIndex:section]];
        return [sectionNameArray count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([filteredArray count] > 0) {
        return 1;
    } else {
        return [keys count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if (filteredArray.count > 0) {
        cell.textLabel.text = [filteredArray objectAtIndex:indexPath.row];
    }else{
        NSArray *sectionNameArray = [nameDic objectForKey:[keys objectAtIndex:indexPath.section]];
        if ([keys count] > 0) {
            cell.textLabel.text = [sectionNameArray objectAtIndex:indexPath.row];
        }
    }
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return indexArray;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self filterContentForSearchText:searchFriendsSearchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    [friendsTableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchFriendsSearchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    [friendsTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *friendName = [dataSourceArray objectAtIndex: [alertView tag]];
        [[NSUserDefaults standardUserDefaults] setObject:friendName forKey:@"OpponentName"];
        
        VSFOptionsViewController *optionsViewController = [[VSFOptionsViewController alloc] init];
        [self.navigationController pushViewController:optionsViewController animated:YES];
    }
}

#pragma mark - privateMethods
- (void)defaultInit
{
    UIBarButtonItem *backButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                     style:UIBarButtonItemStyleBordered
                                    target:nil
                                    action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    self.title = @"Facebook Friends";
    self.view.backgroundColor = [UIColor whiteColor];
    
    searchFriendsSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(SEARCH_FRIENDS_SEARCHBAR_X, SEARCH_FRIENDS_SEARCHBAR_Y * SCREEN_HEIGHT, SEARCH_FRIENDS_SEARCHBAR_W, SEARCH_FRIENDS_SEARCHBAR_H * SCREEN_HEIGHT)];
    searchFriendsSearchBar.delegate = self;
    searchFriendsSearchBar.barStyle = UIBarStyleDefault;
    searchFriendsSearchBar.placeholder = @"Search";
    searchFriendsSearchBar.keyboardType = UIKeyboardTypeDefault;
    
    friendsTableView = [[UITableView alloc] initWithFrame:CGRectMake(FRIENDS_TABLEVIEW_X, FRIENDS_TABLEVIEW_Y * SCREEN_HEIGHT, FRIENDS_TABLEVIEW_W, SCREEN_HEIGHT - 20 - 44) style:UITableViewStylePlain];
    friendsTableView.delegate = self;
    friendsTableView.dataSource = self;
    [self.view addSubview:friendsTableView];
    friendsTableView.tableHeaderView = searchFriendsSearchBar;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [filteredArray removeAllObjects];
    // filter array by NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    filteredArray = [NSMutableArray arrayWithArray:[friendsNameArray filteredArrayUsingPredicate:predicate]];
}

- (void)friendsDivideIntoGroup
{
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
