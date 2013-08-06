//
//  VSFStartNewGameViewController.m
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFStartNewGameViewController.h"
#import "VSFEmailViewController.h"
#import "VSFFacebookFriendsViewController.h"
#import "VSFOptionsViewController.h"
#import "VSFContactsViewController.h"

// New opponent table view
#define NEW_OPPONENT_TABLEVIEW_X 20
#define NEW_OPPONENT_TABLEVIEW_Y 0.05
#define NEW_OPPONENT_TABLEVIEW_W 280
#define NEW_OPPONENT_TABLEVIEW_H (CELL_H * 4 + HEADER_H)
// Previous opponent table view
#define PREVIOUS_OPPONENT_TABLEVIEW_X 20
#define PREVIOUS_OPPONENT_TABLEVIEW_Y (CELL_H * 4 + HEADER_H + 0.06)
#define PREVIOUS_OPPONENT_TABLEVIEW_W 280
#define PREVIOUS_OPPONENT_TABLEVIEW_H (CELL_H * 2 + HEADER_H)
// Rematch button
#define REMATCH_BUTTON_X 160
#define REMATCH_BUTTON_Y 0.2
#define REMATCH_BUTTON_W 100
#define REMATCH_BUTTON_H 0.8
// Cell
#define CELL_H 0.1
// Tableview header
#define HEADER_H 0.05

@interface VSFStartNewGameViewController () {
    NSArray *newOpponentListDataArray;
    NSArray *previousOpponentListDataArray;
}

- (void)defaultInit;
- (void)clickOnRematch: (id)sender;

@end

@implementation VSFStartNewGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        newOpponentListDataArray = [[NSArray alloc] initWithObjects:@"Facebook Friends", @"By Email", @"Contact List",  @"Random Opponent", nil];
        previousOpponentListDataArray = [[NSArray alloc] initWithObjects:@"Billy Bob Bozos", @"Jeremy Lu", @"Doris Huang", @"Jessie Hu", @"Andrew Zhao", @"Sean Hu", nil];
        
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

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_H * SCREEN_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADER_H * SCREEN_HEIGHT;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle;
    if (tableView == newOpponentTableView) {
        headerTitle = @"New Opponents";
    } else if (tableView == previousOpponentTableView) {
        headerTitle = @"Previous Opponents";
    }
    return headerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VSFEmailViewController *emailViewController = [[VSFEmailViewController alloc] init];
    VSFFacebookFriendsViewController *facebookFriendsViewController = [[VSFFacebookFriendsViewController alloc] init];
    VSFContactsViewController *contactsViewController = [[VSFContactsViewController alloc] init];
    if (tableView == newOpponentTableView) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:facebookFriendsViewController animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:emailViewController animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:contactsViewController animated:YES];
                break;
            case 3:
                break;                
            default:
                break;
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView == newOpponentTableView) {
        return newOpponentListDataArray.count;
    } else if (tableView == previousOpponentTableView) {
        return previousOpponentListDataArray.count;
    }else{
        return 0;
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
    
    if (tableView == newOpponentTableView) {
        cell.textLabel.text = [newOpponentListDataArray objectAtIndex:indexPath.row];
    } else if (tableView == previousOpponentTableView) {
        cell.textLabel.text = [previousOpponentListDataArray objectAtIndex:indexPath.row];
        
        UIButton *rematchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        rematchButton.frame = CGRectMake(REMATCH_BUTTON_X, REMATCH_BUTTON_Y * cell.frame.size.height, REMATCH_BUTTON_W, REMATCH_BUTTON_H * cell.frame.size.height);
        [rematchButton setTitle:@"Rematch" forState:UIControlStateNormal];
        [rematchButton addTarget:self action:@selector(clickOnRematch:) forControlEvents:UIControlEventTouchUpInside];
        rematchButton.tag = indexPath.row;
        [cell.contentView addSubview:rematchButton];

    }
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return cell;
}

#pragma mark - UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *friendName = [previousOpponentListDataArray objectAtIndex: [alertView tag]];
        [[NSUserDefaults standardUserDefaults] setObject:friendName forKey:@"OpponentName"];
        
        VSFOptionsViewController *optionsViewController = [[VSFOptionsViewController alloc] init];
        [self.navigationController pushViewController:optionsViewController animated:YES];
    }
}

#pragma mark - private methods
- (void)defaultInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Start a Game";

    newOpponentTableView = [[UITableView alloc] init];
    [newOpponentTableView setFrame:CGRectMake(NEW_OPPONENT_TABLEVIEW_X, NEW_OPPONENT_TABLEVIEW_Y * SCREEN_HEIGHT, NEW_OPPONENT_TABLEVIEW_W, NEW_OPPONENT_TABLEVIEW_H * SCREEN_HEIGHT)];
    newOpponentTableView.scrollEnabled = NO;
    newOpponentTableView.delegate = self;
    newOpponentTableView.dataSource = self;
    [self.view addSubview:newOpponentTableView];
    
    previousOpponentTableView = [[UITableView alloc] init];
    [previousOpponentTableView setFrame:CGRectMake(PREVIOUS_OPPONENT_TABLEVIEW_X, PREVIOUS_OPPONENT_TABLEVIEW_Y * SCREEN_HEIGHT, PREVIOUS_OPPONENT_TABLEVIEW_W, PREVIOUS_OPPONENT_TABLEVIEW_H * SCREEN_HEIGHT)];
    previousOpponentTableView.scrollEnabled = YES;
    previousOpponentTableView.delegate = self;
    previousOpponentTableView.dataSource = self;
    [self.view addSubview:previousOpponentTableView];
}

- (void)clickOnRematch: (id)sender
{
    NSString *message = [NSString stringWithFormat:@"Would you like to start a game with %@", [previousOpponentListDataArray objectAtIndex: [sender tag]]];
    UIAlertView *confirmationAlertView = [[UIAlertView alloc] initWithTitle:@"Start Game" message:message delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    confirmationAlertView.tag = [sender tag];
    [confirmationAlertView show];

}

@end
