//
//  VSFHomeViewController.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFHomeViewController.h"
#import "VSFCommonDefine.h"
#import "IIViewDeckController.h"
#import "VSFGameSummaryViewController.h"

#define CELL_H 40
#define HEADER_H 20
// BackGround Image
#define BACKGROUND_IMAGE_X 0
#define BACKGROUND_IMAGE_Y 0
#define BACKGROUND_IMAGE_W 320
#define BACKGROUND_IMAGE_H 1
// Go back button
#define GOBACK_BUTTON_X 10
#define GOBACK_BUTTON_Y 0.08
#define GOBACK_BUTTON_W 60
#define GOBACK_BUTTON_H 0.06
// ScrollView
#define SCROLLVIEW_X 0
#define SCROLLVIEW_Y 0.1
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
// title label
#define TITLELABEL_X 0
#define TITLELABEL_Y 0
#define TITLELABEL_W 320
#define TITLELABEL_H 0.1
// menu icon button
#define EMNUBUTTON_X 10
#define EMNUBUTTON_Y 0.02
#define EMNUBUTTON_W 30
#define EMNUBUTTON_H 0.07
// add icon button
#define ADDBUTTON_X (320 - EMNUBUTTON_X - ADDBUTTON_W)
#define ADDBUTTON_Y 0.02
#define ADDBUTTON_W 30
#define ADDBUTTON_H 0.07

@interface VSFHomeViewController ()

- (void)initUI;
- (void)playbookClick;
- (void)clickOnBackButton;
- (void)menuIconButtonClick;
- (void)addIconButtonClick;

@end

@implementation VSFHomeViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)initUI
{
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    stepInfoScrollView = [[UIScrollView alloc] init];
    [stepInfoScrollView setFrame:CGRectMake(SCROLLVIEW_X, SCROLLVIEW_Y * SCREEN_HEIGHT, SCROLLVIEW_W, SCROLLVIEW_H * SCREEN_HEIGHT)];
    stepInfoScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:stepInfoScrollView];
    
    stepInfoScrollView.contentSize = CGSizeMake(SCROLLVIEW_Y * SCREEN_HEIGHT, RESULT_TABLE_Y * SCREEN_HEIGHT + HEADER_H + CELL_H * [resultArray count]);
    
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
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(TITLELABEL_X, TITLELABEL_Y * SCREEN_HEIGHT, TITLELABEL_W, TITLELABEL_H * SCREEN_HEIGHT)];
    [titleLabel setText:@"Vs. Football"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:24.0f]];
    [self.view addSubview:titleLabel];
    
    UIButton *menuIconButton = [[UIButton alloc] init];
    [menuIconButton setFrame:CGRectMake(EMNUBUTTON_X, EMNUBUTTON_Y * SCREEN_HEIGHT, EMNUBUTTON_W, EMNUBUTTON_H * SCREEN_HEIGHT)];
    menuIconButton.backgroundColor = [UIColor blueColor];
    [menuIconButton setBackgroundImage:[UIImage imageNamed:@"menu_icon.png"] forState:UIControlStateNormal];
    [menuIconButton addTarget:self action:@selector(menuIconButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuIconButton];
    
    UIButton *addIconButton = [[UIButton alloc] init];
    [addIconButton setFrame:CGRectMake(ADDBUTTON_X, ADDBUTTON_Y * SCREEN_HEIGHT, ADDBUTTON_W, ADDBUTTON_H * SCREEN_HEIGHT)];
    addIconButton.backgroundColor = [UIColor blueColor];
    [addIconButton setBackgroundImage:[UIImage imageNamed:@"add_icon.png"] forState:UIControlStateNormal];
    [addIconButton addTarget:self action:@selector(addIconButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addIconButton];
    
    
//    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BACKGROUND_IMAGE_X,
//                                                                               BACKGROUND_IMAGE_Y * SCREEN_HEIGHT,
//                                                                               BACKGROUND_IMAGE_W,
//                                                                               BACKGROUND_IMAGE_H * SCREEN_HEIGHT)];
//    [backImageView setImage:[UIImage imageNamed:@"bg_1.jpg"]];
//    [self.view addSubview:backImageView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setFrame:CGRectMake(GOBACK_BUTTON_X,
                                    GOBACK_BUTTON_Y * SCREEN_HEIGHT,
                                    GOBACK_BUTTON_W,
                                    GOBACK_BUTTON_H * SCREEN_HEIGHT)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickOnBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)playbookClick
{
    
}

- (void)clickOnBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)menuIconButtonClick
{
    IIViewDeckController *dectController = [[IIViewDeckController alloc] init];
}

- (void)addIconButtonClick
{
    
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
    VSFGameSummaryViewController *gameSummaryViewController = [[VSFGameSummaryViewController alloc] init];
    [self.navigationController pushViewController:gameSummaryViewController animated:YES];
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

@end
