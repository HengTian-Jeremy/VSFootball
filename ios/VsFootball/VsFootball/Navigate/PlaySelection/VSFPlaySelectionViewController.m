//
//  VSFPlaySelectionViewController.m
//  VsFootball
//
//  Created by hjy on 7/30/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlaySelectionViewController.h"
#import "VSFADBannerView.h"

// Title label
#define TITLELABEL_X 0
#define TITLELABEL_Y 0
#define TITLELABEL_W 320
#define TITLELABEL_H 0.1
// Back  button
#define BACKBUTTON_X 10
#define BACKBUTTON_Y 0.02
#define BACKBUTTON_W 60
#define BACKBUTTON_H 0.07
// Tactics tableview
#define TACTICS_TABLEVIEW_X 10
#define TACTICS_TABLEVIEW_Y 0.26
#define TACTICS_TABLEVIEW_W 300
#define TACTICS_TABLEVIEW_H 0.6
// Run button
#define RUN_BUTTON_X 40
#define RUN_BUTTON_Y 0.18
#define RUN_BUTTON_W 60
#define RUN_BUTTON_H 0.07
// Pass button
#define PASS_BUTTON_X 100
#define PASS_BUTTON_Y 0.18
#define PASS_BUTTON_W 60
#define PASS_BUTTON_H 0.07
// Special team button
#define SPECIAL_TEAM_BUTTON_X 160
#define SPECIAL_TEAM_BUTTON_Y 0.18
#define SPECIAL_TEAM_BUTTON_W 120
#define SPECIAL_TEAM_BUTTON_H 0.07
// Board imageview
#define BOARD_IMAGEVIEW_X 0
#define BOARD_IMAGEVIEW_Y 0.1
#define BOARD_IMAGEVIEW_W 320
#define BOARD_IMAGEVIEW_H 0.07
// Tactics label
#define TACTICS_LABEL_X 10
#define TACTICS_LABEL_Y 5
#define TACTICS_LABEL_W 280
#define TACTICS_LABEL_H 30
// Tactics imageview
#define TACTICS_IMAGEVIEW_X 10
#define TACTICS_IMAGEVIEW_Y 50
#define TACTICS_IMAGEVIEW_W 280
#define TACTICS_IMAGEVIEW_H 100

@interface VSFPlaySelectionViewController (){
    BOOL isOpen;
    int selectionTypeNumber;
    NSIndexPath *selectedIndex;
}

- (void)defaultInit;
- (void)clickOnBack;
- (void)clickOnRun;
- (void)clickOnPass;
- (void)clickOnSpecialTeams;

@end

@implementation VSFPlaySelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        playSelectionType = [[NSUserDefaults standardUserDefaults] objectForKey:@"playSelectionType"];
        if (playSelectionType != nil) {
            if ([@"Offensive Play" isEqualToString: playSelectionType]) {
                selectionTypeNumber = 0;
            }else if([@"Defensive Play" isEqualToString: playSelectionType]){
                selectionTypeNumber = 3;
            }
        }

        runTacticsOffensiveArray = [[NSMutableArray alloc] initWithObjects:@"HB Lead Dive", @"Off Tackle", @"HB Lead Toss", @"FB Dive", @"QB Sneak", @"End Around", @"Shotgun Draw", @"QB Bootleg", @"Quick Toss", @"HB Counter Weak", @"WR Reverse - ($)", @"HB Veer - ($)", nil];
        passTacticsOffensiveArray = [[NSMutableArray alloc] initWithObjects:@"HB", @"Screen", @"FB Loop", @"TE GO", @"WR", @"X Hook", @"Y Cross", @"Y Corner", @"HB Pass", nil];
        specialTeamsTacticsOffensiveArray = [[NSMutableArray alloc] initWithObjects:@"Punt", @"Punt Max Project", @"Punt Return", @"Field Goal", @"Field Goal Safe", @"Deep", nil];
        runTacticsDefensiveArray = [[NSMutableArray alloc] initWithObjects:@"4-3 Overshift Mombo", @"4-3 Under", @"Nickel", @"Dime", @"4-3 Man",  @"4-3 Zone",  @"4-3 Crash Blitz",  @"4-3 SS Blitz", nil];
        passTacticsDefensiveArray = [[NSMutableArray alloc] initWithObjects:@"HB", @"Screen", @"FB Loop", @"TE GO", @"WR", @"X Hook", @"Y Cross", @"Y Corner", @"HB Pass", nil];
        specialTeamsTacticsDefensiveArray = [[NSMutableArray alloc] initWithObjects:@"Punt", @"Punt Max Project", @"Punt Return", @"Field Goal", @"Field Goal Safe", @"Deep", nil];
        
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
    if (indexPath.row == selectedIndex.row && selectedIndex != nil ) {
        if (isOpen == YES) {
            return 160;
        }else{
            return 40;
        }        
    }else{
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    if (selectedIndex != nil && indexPath.row == selectedIndex.row) {
        isOpen = !isOpen;
    }else if (selectedIndex != nil && indexPath.row != selectedIndex.row) {
        indexPaths = [NSArray arrayWithObjects:indexPath, selectedIndex, nil];
        isOpen = YES;
    }else{
        isOpen = !isOpen;
    }
    
    selectedIndex = indexPath;
    // refresh
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    switch (selectionTypeNumber) {
        case 0:
            return [runTacticsOffensiveArray count];
            break;
        case 1:
            return [passTacticsOffensiveArray count];
            break;
        case 2:
            return [specialTeamsTacticsOffensiveArray count];
            break;
        case 3:
            return [runTacticsDefensiveArray count];
            break;
        case 4:
            return [passTacticsDefensiveArray count];
            break;
        case 5:
            return [specialTeamsTacticsDefensiveArray count];
            break;
        default:
            return 0;
            break;
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
    
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
    
    NSArray *dataSourceArray;
    switch (selectionTypeNumber) {
        case 0:
            dataSourceArray = runTacticsOffensiveArray;
            break;
        case 1:
            dataSourceArray = passTacticsOffensiveArray;
            break;
        case 2:
            dataSourceArray = specialTeamsTacticsOffensiveArray;
            break;
        case 3:
            dataSourceArray = runTacticsDefensiveArray;
            break;
        case 4:
            dataSourceArray = passTacticsDefensiveArray;
            break;
        case 5:
           dataSourceArray = specialTeamsTacticsDefensiveArray;
            break;
        default:
            break;
    }
    
    UILabel *tacticsLabel = [[UILabel alloc] init];    
    [tacticsLabel setText: [dataSourceArray objectAtIndex:indexPath.row]];
    [tacticsLabel setTextAlignment:NSTextAlignmentLeft];
    
    UIImageView *tacticsImageView = [[UIImageView alloc] init];
    
    if (indexPath.row == selectedIndex.row && selectedIndex != nil) {
        if (isOpen == YES) {
            [tacticsLabel setFrame:CGRectMake(TACTICS_LABEL_X, TACTICS_LABEL_Y, TACTICS_LABEL_W, TACTICS_LABEL_H)];
            [tacticsImageView setFrame:CGRectMake(TACTICS_IMAGEVIEW_X, TACTICS_IMAGEVIEW_Y, TACTICS_IMAGEVIEW_W, TACTICS_IMAGEVIEW_H)];
            [tacticsImageView setImage: [UIImage imageNamed:@"tactics"]];
            [cell.contentView addSubview: tacticsLabel];
            [cell.contentView addSubview: tacticsImageView];
        }else{
            [tacticsLabel setFrame:CGRectMake(TACTICS_LABEL_X, TACTICS_LABEL_Y, TACTICS_LABEL_W, TACTICS_LABEL_H)];
            [cell.contentView addSubview: tacticsLabel];
        }
    } else {
        [tacticsLabel setFrame:CGRectMake(TACTICS_LABEL_X, TACTICS_LABEL_Y, TACTICS_LABEL_W, TACTICS_LABEL_H)];
        [cell.contentView addSubview: tacticsLabel];
    }
    
    return cell;
}

#pragma mark - private methods
- (void)defaultInit
{
    titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(TITLELABEL_X, TITLELABEL_Y * SCREEN_HEIGHT, TITLELABEL_W, TITLELABEL_H * SCREEN_HEIGHT)];
    [titleLabel setText: playSelectionType];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:24.0f]];
    [self.view addSubview:titleLabel];
    
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setFrame:CGRectMake(BACKBUTTON_X, BACKBUTTON_Y * SCREEN_HEIGHT, BACKBUTTON_W, BACKBUTTON_H * SCREEN_HEIGHT)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickOnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    boardImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"board"]];
    boardImageView.frame = CGRectMake(BOARD_IMAGEVIEW_X, BOARD_IMAGEVIEW_Y * SCREEN_HEIGHT, BOARD_IMAGEVIEW_W, BOARD_IMAGEVIEW_H * SCREEN_HEIGHT);
    boardImageView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview: boardImageView];
    
    runButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [runButton setFrame:CGRectMake(RUN_BUTTON_X, RUN_BUTTON_Y * SCREEN_HEIGHT, RUN_BUTTON_W, RUN_BUTTON_H * SCREEN_HEIGHT)];
    [runButton setTitle:@"Run" forState:UIControlStateNormal];
    [runButton addTarget:self action:@selector(clickOnRun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: runButton];
    
    passButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [passButton setFrame:CGRectMake(PASS_BUTTON_X, PASS_BUTTON_Y * SCREEN_HEIGHT, PASS_BUTTON_W, PASS_BUTTON_H * SCREEN_HEIGHT)];
    [passButton setTitle:@"Pass" forState:UIControlStateNormal];
    [passButton addTarget:self action:@selector(clickOnPass) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: passButton];
    
    specialTeamButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [specialTeamButton setFrame:CGRectMake(SPECIAL_TEAM_BUTTON_X, SPECIAL_TEAM_BUTTON_Y * SCREEN_HEIGHT, SPECIAL_TEAM_BUTTON_W, SPECIAL_TEAM_BUTTON_H * SCREEN_HEIGHT)];
    [specialTeamButton setTitle:@"Special Teams" forState:UIControlStateNormal];
    [specialTeamButton addTarget:self action:@selector(clickOnSpecialTeams) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: specialTeamButton];
    
    tacticsTableView = [[UITableView alloc] init];
    [tacticsTableView setFrame:CGRectMake(TACTICS_TABLEVIEW_X, TACTICS_TABLEVIEW_Y * SCREEN_HEIGHT, TACTICS_TABLEVIEW_W, TACTICS_TABLEVIEW_H * SCREEN_HEIGHT)];
    tacticsTableView.scrollEnabled = YES;
    tacticsTableView.delegate = self;
    tacticsTableView.dataSource = self;
    [self.view addSubview:tacticsTableView];
    
    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, self.view.bounds.size.height - 50, 320, 50);
    [self.view addSubview:[VSFADBannerView getAdBannerView]];
}

- (void)clickOnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickOnRun
{
    isOpen = NO;
    if (playSelectionType != nil) {
        if ([@"Offensive Play" isEqualToString: playSelectionType]){
            selectionTypeNumber = 0;
        }else if([@"Defensive Play" isEqualToString: playSelectionType]) {
            selectionTypeNumber = 3;
        }
        [tacticsTableView reloadData];
    }
}

- (void)clickOnPass
{
    isOpen = NO;
    if (playSelectionType != nil) {
        if ([@"Offensive Play" isEqualToString: playSelectionType]){
            selectionTypeNumber = 1;
        }else if([@"Defensive Play" isEqualToString: playSelectionType]) {
            selectionTypeNumber = 4;
        }
        [tacticsTableView reloadData];
    }
}

- (void)clickOnSpecialTeams
{
    isOpen = NO;
    if (playSelectionType != nil) {
        if ([@"Offensive Play" isEqualToString: playSelectionType]){
            selectionTypeNumber = 2;
        }else if([@"Defensive Play" isEqualToString: playSelectionType]) {
            selectionTypeNumber = 5;
        }
        [tacticsTableView reloadData];
    }
}

@end