//
//  VSFStartNewGameViewController.m
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFStartNewGameViewController.h"
#import "VSFADBannerView.h"

// Title label
#define TITLELABEL_X 0
#define TITLELABEL_Y 0
#define TITLELABEL_W 320
#define TITLELABEL_H 0.1
// Opponent table view
#define OPPONENT_TABLEVIEW_X 20
#define OPPONENT_TABLEVIEW_Y 0.2
#define OPPONENT_TABLEVIEW_W 280
#define OPPONENT_TABLEVIEW_H CELL_H * 4
// Back button
#define GOBACK_BUTTON_X 10
#define GOBACK_BUTTON_Y 0.02
#define GOBACK_BUTTON_W 60
#define GOBACK_BUTTON_H 0.06
// Cell
#define CELL_H 0.1

@interface VSFStartNewGameViewController (){
    NSArray *opponentListDataArray;
}

- (void)defaultInit;
- (void)clickOnBackButton;

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
        opponentListDataArray = [[NSArray alloc] initWithObjects:@"Facebook Friends", @"Contact List", @"By Username/Email", @"Random Opponent", nil];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return opponentListDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.textLabel.text = [opponentListDataArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return cell;
}

#pragma mark - private methods
- (void)defaultInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(TITLELABEL_X, TITLELABEL_Y * SCREEN_HEIGHT, TITLELABEL_W, TITLELABEL_H * SCREEN_HEIGHT)];
    [titleLabel setText:@"Start a Game"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:24.0f]];
    [self.view addSubview:titleLabel];

    opponentTableView = [[UITableView alloc] init];
    [opponentTableView setFrame:CGRectMake(OPPONENT_TABLEVIEW_X, OPPONENT_TABLEVIEW_Y * SCREEN_HEIGHT, OPPONENT_TABLEVIEW_W, OPPONENT_TABLEVIEW_H * SCREEN_HEIGHT)];
    opponentTableView.scrollEnabled = NO;
    opponentTableView.delegate = self;
    opponentTableView.dataSource = self;
    [self.view addSubview:opponentTableView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setFrame:CGRectMake(GOBACK_BUTTON_X, GOBACK_BUTTON_Y * SCREEN_HEIGHT, GOBACK_BUTTON_W, GOBACK_BUTTON_H * SCREEN_HEIGHT)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickOnBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, self.view.bounds.size.height - 50, 320, 50);
    [self.view addSubview:[VSFADBannerView getAdBannerView]];
}

- (void)clickOnBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
