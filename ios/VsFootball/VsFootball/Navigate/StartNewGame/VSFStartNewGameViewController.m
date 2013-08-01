//
//  VSFStartNewGameViewController.m
//  VsFootball
//
//  Created by hjy on 7/31/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFStartNewGameViewController.h"

// Opponent table view
#define OPPONENT_TABLEVIEW_X 20
#define OPPONENT_TABLEVIEW_Y 0.2
#define OPPONENT_TABLEVIEW_W 280
#define OPPONENT_TABLEVIEW_H CELL_H * 4
// Cell
#define CELL_H 0.1

@interface VSFStartNewGameViewController () {
    NSArray *opponentListDataArray;
}

- (void)defaultInit;

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
    
    self.title = @"Start a Game";

    opponentTableView = [[UITableView alloc] init];
    [opponentTableView setFrame:CGRectMake(OPPONENT_TABLEVIEW_X, OPPONENT_TABLEVIEW_Y * SCREEN_HEIGHT, OPPONENT_TABLEVIEW_W, OPPONENT_TABLEVIEW_H * SCREEN_HEIGHT)];
    opponentTableView.scrollEnabled = NO;
    opponentTableView.delegate = self;
    opponentTableView.dataSource = self;
    [self.view addSubview:opponentTableView];
}

@end
