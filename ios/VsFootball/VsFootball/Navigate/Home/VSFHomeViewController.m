//
//  VSFHomeViewController.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFHomeViewController.h"
#import "DDMenuController.h"
#import "VSFAppDelegate.h"
#import "VSFPlaybookViewController.h"
#import "VSFADBannerView.h"
#import "VSFCommonDefine.h"
#import "VSFGameSummaryViewController.h"
#import "VSFStartNewGameViewController.h"
#import "VSFCommonDefine.h"

#define CELL_H 40
#define HEADER_H 20
// ScrollView
#define SCROLLVIEW_X 0
#define SCROLLVIEW_Y 0
#define SCROLLVIEW_W 320
#define SCROLLVIEW_H 1
// Your Turn TableView
#define YOURTURN_TABLE_X 20
#define YOURTURN_TABLE_Y 0.05
#define YOURTURN_TABLE_W 280
// Their Turn TableView
#define THEIRTURN_TABLE_X 20
#define THEIRTURN_TABLE_Y 0.3
#define THEIRTURN_TABLE_W 280
// result TableView
#define RESULT_TABLE_X 20
#define RESULT_TABLE_Y 0.65
#define RESULT_TABLE_W 280
// EGO Refresh Table Header View
#define REFRESH_TABLE_HEADER_VIEW_X 0
#define REFRESH_TABLE_HEADER_VIEW_W 320

@interface VSFHomeViewController ()

- (void)initUI;
- (void)playbookClick;
- (void)addGameButtonClick;
- (void)backButtonClick;

@end

@implementation VSFHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
        backBarButtonItem.title = @"Back";
        backBarButtonItem.target = self;
        backBarButtonItem.action = @selector(backButtonClick);
        self.navigationItem.backBarButtonItem = backBarButtonItem;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    yourTurnArray = [NSArray arrayWithObjects:@"D-CLAW vs. Favre Doolar Ftlong", @"Sproles Royce vs. D_CLAW", nil];
    theirTurnArray = [NSArray arrayWithObjects:@"Favre Dollar Footlong vs. D-CLAW",@"D-CLAW vs. RG-3PO", @"D-CLAW vs. Rice Rice Baby", nil];
    resultArray = [NSArray arrayWithObjects:@"You win", nil];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, self.view.bounds.size.height - 50, 320, 50);
    [self.view addSubview:[VSFADBannerView getAdBannerView]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)initUI
{
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    self.title = @"Vs. Football";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGameButtonClick)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    stepInfoScrollView = [[UIScrollView alloc] init];
    stepInfoScrollView.delegate = self;
    stepInfoScrollView.scrollEnabled = YES;
    [stepInfoScrollView setFrame:CGRectMake(SCROLLVIEW_X, SCROLLVIEW_Y * SCREEN_HEIGHT, SCROLLVIEW_W, SCROLLVIEW_H * SCREEN_HEIGHT)];
    stepInfoScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:stepInfoScrollView];
//    stepInfoScrollView.contentSize = CGSizeMake(SCROLLVIEW_Y * SCREEN_HEIGHT, RESULT_TABLE_Y * SCREEN_HEIGHT + HEADER_H + CELL_H * [resultArray count]);
    stepInfoScrollView.contentSize = CGSizeMake(SCROLLVIEW_Y * SCREEN_HEIGHT, SCROLLVIEW_H * SCREEN_HEIGHT * 2);
    
    yourTurnTableView = [[UITableView alloc] init];
    [yourTurnTableView setFrame:CGRectMake(YOURTURN_TABLE_X, YOURTURN_TABLE_Y * SCREEN_HEIGHT, YOURTURN_TABLE_W, HEADER_H + CELL_H * [yourTurnArray count])];
    yourTurnTableView.scrollEnabled = NO;
    yourTurnTableView.delegate = self;
    yourTurnTableView.dataSource = self;
    [stepInfoScrollView addSubview:yourTurnTableView];
    
    theirTurnTabelView = [[UITableView alloc] init];
    [theirTurnTabelView setFrame:CGRectMake(THEIRTURN_TABLE_X, THEIRTURN_TABLE_Y * SCREEN_HEIGHT, THEIRTURN_TABLE_W, HEADER_H + CELL_H * [theirTurnArray count])];
    theirTurnTabelView.scrollEnabled = NO;
    theirTurnTabelView.delegate = self;
    theirTurnTabelView.dataSource = self;
    [stepInfoScrollView addSubview:theirTurnTabelView];
    
    resultTableView = [[UITableView alloc] init];
    [resultTableView setFrame:CGRectMake(RESULT_TABLE_X, RESULT_TABLE_Y * SCREEN_HEIGHT, RESULT_TABLE_W, HEADER_H + CELL_H * [resultArray count])];
    resultTableView.scrollEnabled = NO;
    resultTableView.delegate = self;
    resultTableView.dataSource = self;
    [stepInfoScrollView addSubview:resultTableView];
    
    if (refreshHeaderView == nil) {
        EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(REFRESH_TABLE_HEADER_VIEW_X, -stepInfoScrollView.bounds.size.height, REFRESH_TABLE_HEADER_VIEW_W, stepInfoScrollView.bounds.size.height)];
        view.delegate = self;
        [stepInfoScrollView addSubview:view];
        refreshHeaderView = view;
    }
    [refreshHeaderView refreshLastUpdatedDate];
}

- (void)playbookClick
{
    
}

- (void)addGameButtonClick
{
    VSFStartNewGameViewController *startNewGameViewController = [[VSFStartNewGameViewController alloc] init];
    [self.navigationController pushViewController:startNewGameViewController animated:YES];
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_H;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADER_H;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDMenuController *homeMenuController = (DDMenuController *)((VSFAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    VSFPlaybookViewController *playbookController = [[VSFPlaybookViewController alloc] init];
    homeMenuController.leftViewController = playbookController;
    VSFGameSummaryViewController *gameSummaryController = [[VSFGameSummaryViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gameSummaryController];
    [homeMenuController setRootController:navController animated:YES];
    NSLog(@"%f", self.view.frame.size.height);
//    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, SCREEN_HEIGHT - 20 - 44, 320, 50);
//    [homeMenuController.view addSubview:[VSFADBannerView getAdBannerView]];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (tableView == yourTurnTableView) {
        [userDefaults setObject:@"Offensive Play" forKey:@"playSelectionType"];
    }else if (tableView == theirTurnTabelView){
        [userDefaults setObject:@"Defensive Play" forKey:@"playSelectionType"];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSInteger rowsNum = 0;
    if (tableView == yourTurnTableView) {
        rowsNum = [yourTurnArray count];
    } else if (tableView == theirTurnTabelView) {
        rowsNum = [theirTurnArray count];
    } else if (tableView == resultTableView) {
        rowsNum = [resultArray count];
    }
    return rowsNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSString *labelText;
    if (tableView == yourTurnTableView) {
        labelText = [yourTurnArray objectAtIndex:indexPath.row];
    } else if (tableView == theirTurnTabelView) {
        labelText = [theirTurnArray objectAtIndex:indexPath.row];
    } else if (tableView == resultTableView) {
        labelText = [resultArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = labelText;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle;
    if (tableView == yourTurnTableView) {
        headerTitle = @"Your Turn";
    } else if (tableView == theirTurnTabelView) {
        headerTitle = @"Their Turn";
    } else if (tableView == resultTableView) {
        headerTitle = @"Completed Games";
    }
    return headerTitle;
}

#pragma mark - Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource
{	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	isReloading = YES;	
}

- (void)doneLoadingTableViewData
{
	//  model should call this when its done loading
	isReloading = NO;
	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:yourTurnTableView];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:theirTurnTabelView];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:resultTableView];
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
	[refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{	
	[refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
	NSLog(@"egoRefreshTableHeaderDidTriggerRefresh");
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{	
	return isReloading; // should return if data source model is reloading
	NSLog(@"goRefreshTableHeaderDataSourceIsLoading");
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{	
	return [NSDate date]; // should return date data source was last changed
	NSLog(@"egoRefreshTableHeaderDataSourceLastUpdated");
}

@end
