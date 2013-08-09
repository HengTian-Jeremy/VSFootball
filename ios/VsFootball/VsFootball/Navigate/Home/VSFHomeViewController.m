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
#import "VSFHomeProcess.h"
#import "VSFGetGamesResponseEntity.h"

#define CELL_H 40
#define HEADER_H 20
// ScrollView
#define SCROLLVIEW_X 0
#define SCROLLVIEW_Y 44
#define SCROLLVIEW_W 320
#define SCROLLVIEW_H 1
// Your Turn TableView
#define YOURTURN_TABLE_X 5
#define YOURTURN_TABLE_Y 0.05
#define YOURTURN_TABLE_W 310
// Their Turn TableView
#define THEIRTURN_TABLE_X 5
#define THEIRTURN_TABLE_Y 0.3
#define THEIRTURN_TABLE_W 310
// result TableView
#define RESULT_TABLE_X 5
#define RESULT_TABLE_Y 0.65
#define RESULT_TABLE_W 310
// EGO Refresh Table Header View
#define REFRESH_TABLE_HEADER_VIEW_X 0
#define REFRESH_TABLE_HEADER_VIEW_W 320

// Background image
#define BACKGROUND_IMAGE_X 0
#define BACKGROUND_IMAGE_Y 0
#define BACKGROUND_IMAGE_W 320
#define BACKGROUND_IMAGE_H 1

// Title image
#define TITLE_IMAGE_X 0
#define TITLE_IMAGE_Y 0
#define TITLE_IMAGE_W 320
#define TITLE_IMAGE_H 44

// Seprate line left
#define LEFT_LINE_X 50
#define LEFT_LINE_Y 0
#define LEFT_LINE_W 2
#define LEFT_LINE_H 44

// Seprate line right
#define RIGHT_LINE_X 270
#define RIGHT_LINE_Y 0
#define RIGHT_LINE_W 2
#define RIGHT_LINE_H 44

// Nav drawer left button
#define LEFT_BUTTON_X 10
#define LEFT_BUTTON_Y 7
#define LEFT_BUTTON_W 30
#define LEFT_BUTTON_H 30

// Nav drawer left button
#define RIGHT_BUTTON_X 280
#define RIGHT_BUTTON_Y 7
#define RIGHT_BUTTON_W 30
#define RIGHT_BUTTON_H 30

// Title Label
#define TITLE_LABEL_X 55
#define TITLE_LABEL_Y 2
#define TITLE_LABEL_W 210
#define TITLE_LABEL_H 44


@interface VSFHomeViewController ()

- (void)initUI;
- (void)playbookClick;
- (void)addGameButtonClick;
- (void)backButtonClick;
- (void)leftButtonClick;

@end

@implementation VSFHomeViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] init];
//        backBarButtonItem.title = @"Back";
//        backBarButtonItem.target = self;
//        backBarButtonItem.action = @selector(backButtonClick);
//        self.navigationItem.backBarButtonItem = backBarButtonItem;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        process = [[VSFHomeProcess alloc] init];
        process.delegate = self;
//        [process getGameList];
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
//    yourTurnArray = [[NSArray alloc] init];
//    theirTurnArray = [[NSArray alloc] init];
//    resultArray = [[NSArray alloc] init];
    
    [self initUI];
    
//    VSFHomeProcess *homeProcess = [[VSFHomeProcess alloc] init];
//    [homeProcess getGame];
    [process getGameList];
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
    
//    self.title = @"Vs. Football";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGameButtonClick)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIImageView *backgroudImage = [[UIImageView alloc] initWithFrame:CGRectMake(BACKGROUND_IMAGE_X,
                                                                                BACKGROUND_IMAGE_Y * SCREEN_HEIGHT,
                                                                                BACKGROUND_IMAGE_W,
                                                                                BACKGROUND_IMAGE_H * SCREEN_HEIGHT)];
    if (SCREEN_HEIGHT > 480) {
        [backgroudImage setImage:[UIImage imageNamed:@"i4_bg"]];
    } else {
        [backgroudImage setImage:[UIImage imageNamed:@"i5_bg"]];
    }
    [self.view addSubview:backgroudImage];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(TITLE_IMAGE_X, TITLE_IMAGE_Y, TITLE_IMAGE_W, TITLE_IMAGE_H)];
    [titleImage setImage:[UIImage imageNamed:@"nav-bar_bg"]];
    [self.view addSubview:titleImage];
    
    UIImageView *leftLine = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_LINE_X, LEFT_LINE_Y, LEFT_LINE_W, LEFT_LINE_H)];
    [leftLine setImage:[UIImage imageNamed:@"nav-bar_divider"]];
    [self.view addSubview:leftLine];
    
    UIImageView *rightLine = [[UIImageView alloc] initWithFrame:CGRectMake(RIGHT_LINE_X, RIGHT_LINE_Y, RIGHT_LINE_W, RIGHT_LINE_H)];
    [rightLine setImage:[UIImage imageNamed:@"nav-bar_divider"]];
    [self.view addSubview:rightLine];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(TITLE_LABEL_X, TITLE_LABEL_Y, TITLE_LABEL_W, TITLE_LABEL_H)];
    titleLabel.text = @"Vs. Football";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"SketchRockwell" size:28.0];
    [self.view addSubview:titleLabel];
    
    [leftButton setFrame:CGRectMake(LEFT_BUTTON_X, LEFT_BUTTON_Y, LEFT_BUTTON_W, LEFT_BUTTON_H)];
    leftButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftButton];
    
    [rightButton setFrame:CGRectMake(RIGHT_BUTTON_X, RIGHT_BUTTON_Y, RIGHT_BUTTON_W, RIGHT_BUTTON_H)];
    rightButton.backgroundColor = [UIColor blueColor];
    [rightButton addTarget:self action:@selector(addGameButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    
    
    stepInfoScrollView = [[UIScrollView alloc] init];
    stepInfoScrollView.delegate = self;
    stepInfoScrollView.scrollEnabled = YES;
    [stepInfoScrollView setFrame:CGRectMake(SCROLLVIEW_X, SCROLLVIEW_Y, SCROLLVIEW_W, SCROLLVIEW_H * SCREEN_HEIGHT - SCROLLVIEW_Y)];
    stepInfoScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:stepInfoScrollView];
//    stepInfoScrollView.contentSize = CGSizeMake(SCROLLVIEW_Y * SCREEN_HEIGHT, RESULT_TABLE_Y * SCREEN_HEIGHT + HEADER_H + CELL_H * [resultArray count]);
    stepInfoScrollView.contentSize = CGSizeMake(SCROLLVIEW_W, SCROLLVIEW_H * SCREEN_HEIGHT * 1.2);
    
    yourTurnTableView = [[UITableView alloc] init];
    yourTurnTableView.backgroundColor = [UIColor clearColor];
    [yourTurnTableView setFrame:CGRectMake(YOURTURN_TABLE_X, YOURTURN_TABLE_Y * SCREEN_HEIGHT, YOURTURN_TABLE_W, HEADER_H + CELL_H * [yourTurnArray count])];
    yourTurnTableView.scrollEnabled = NO;
    yourTurnTableView.delegate = self;
    yourTurnTableView.dataSource = self;
    [stepInfoScrollView addSubview:yourTurnTableView];
    
    theirTurnTabelView = [[UITableView alloc] init];
    theirTurnTabelView.backgroundColor = [UIColor clearColor];
    [theirTurnTabelView setFrame:CGRectMake(THEIRTURN_TABLE_X, THEIRTURN_TABLE_Y * SCREEN_HEIGHT, THEIRTURN_TABLE_W, HEADER_H + CELL_H * [theirTurnArray count])];
    theirTurnTabelView.scrollEnabled = NO;
    theirTurnTabelView.delegate = self;
    theirTurnTabelView.dataSource = self;
    [stepInfoScrollView addSubview:theirTurnTabelView];
    
    resultTableView = [[UITableView alloc] init];
    resultTableView.backgroundColor = [UIColor clearColor];
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

- (void)leftButtonClick
{
    
}

- (void)playbookClick
{
    
}

- (void)addGameButtonClick
{
    VSFStartNewGameViewController *startNewGameViewController = [[VSFStartNewGameViewController alloc] init];
    VSFAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.rootNavController pushViewController:startNewGameViewController animated:YES];
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
    
    if ([yourTurnArray count] == 0) {
        return nil;
    }
    
    NSString *labelText;
    if (tableView == yourTurnTableView) {
        labelText = [yourTurnArray objectAtIndex:indexPath.row];
//        VSFGamesEntity *gamesEntity = [yourTurnArray objectAtIndex:indexPath.row];
//        labelText = [NSString stringWithFormat:@"%@ vs. %@", gamesEntity.player1TeamName, gamesEntity.player2TeamName];
    } else if (tableView == theirTurnTabelView) {
        labelText = [theirTurnArray objectAtIndex:indexPath.row];
    } else if (tableView == resultTableView) {
        labelText = [resultArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = labelText;
    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.font = [UIFont fontWithName:@"SketchRockwell" size:15.0];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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

#pragma mark - VSFHomeProcessDelegate
- (void)setGamesList:(VSFGetGamesResponseEntity *)respEntity
{
    NSLog(@"setGamesList method");
    
    if ([respEntity.success isEqualToString:@"true"]) {
        NSMutableArray *yourTurnGameListText = [[NSMutableArray alloc] init];
        NSMutableArray *theirTurnGameListText =  [[NSMutableArray alloc] init];
        NSString *gameListText;
        VSFGamesEntity *temp;
        for ( int i = 0 ; i < [respEntity.yourTurnGamesList count] ; i++) {
            temp = [respEntity.yourTurnGamesList objectAtIndex:i];
            gameListText = [NSString stringWithFormat:@"%@ vs. %@",temp.player1TeamName,temp.player2TeamName];
            [yourTurnGameListText addObject:gameListText];
        }
        yourTurnArray = yourTurnGameListText;
        
        
        
        for ( int i = 0 ; i < [respEntity.theirTurnGamesList count] ; i++) {
            temp = [respEntity.theirTurnGamesList objectAtIndex:i];
            gameListText = [NSString stringWithFormat:@"%@ vs. %@",temp.player1TeamName,temp.player2TeamName];
            [theirTurnGameListText addObject:gameListText];
        }
        theirTurnArray = theirTurnGameListText;
        
        [yourTurnTableView reloadData];
        [theirTurnTabelView reloadData];
        
        
        
//        yourTurnArray = respEntity.gamesList;
//        [yourTurnTableView reloadData];
    } else {
        NSLog(@"get game list failed");
    }
}

#pragma mark - SetSEL delegate
- (void)setLeftButtonSel:(id)target withSEL:(SEL)sel
{
    [leftButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}
@end
