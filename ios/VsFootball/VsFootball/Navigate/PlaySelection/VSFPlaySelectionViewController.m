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
#define BACKBUTTON_W 80
#define BACKBUTTON_H 0.07
// Tactics tableview
#define TACTICS_TABLEVIEW_X 10
#define TACTICS_TABLEVIEW_Y 0.25
#define TACTICS_TABLEVIEW_W 300
#define TACTICS_TABLEVIEW_H 0.7
// Tactics imageview
#define TACTICS_IMAGEVIEW_X 10
#define TACTICS_IMAGEVIEW_Y 0.2
#define TACTICS_IMAGEVIEW_W 280
#define TACTICS_IMAGEVIEW_H 0.7

@interface VSFPlaySelectionViewController (){
    BOOL isOpen;
    NSIndexPath *selectedIndex;
}

- (void)defaultInit;
- (void)clickOnBack;

@end

@implementation VSFPlaySelectionViewController
@synthesize playSelectionType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        runTacticsOffensiveArray = [[NSMutableArray alloc] initWithObjects:@"HB Lead Dive", @"Off Tackle", @"HB Lead Toss", @"Quick Toss", @"HB Counter Weak", @"WR Reverse - ($)", @"HB Veer - ($)", nil];
        passTacticsOffensiveArray = [[NSMutableArray alloc] init];
        specialTeamsTacticsOffensiveArray = [[NSMutableArray alloc] init];
        
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
    selectedIndex = indexPath;
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    if (selectedIndex != nil && indexPath.row == selectedIndex.row) {
        isOpen = !isOpen;
    }else if (selectedIndex != nil && indexPath.row != selectedIndex.row) {
        indexPaths = [NSArray arrayWithObjects:indexPath, selectedIndex, nil];
        isOpen = YES;
    }
    
    // refresh
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return runTacticsOffensiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    cell.textLabel.text = [runTacticsOffensiveArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    if (indexPath.row == selectedIndex.row && selectedIndex != nil) {
        if (isOpen == YES) {

        }else{
           
        }
    } else {
    }
    
    return cell;
}

#pragma mark - private methods
- (void)defaultInit
{
    titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(TITLELABEL_X, TITLELABEL_Y * SCREEN_HEIGHT, TITLELABEL_W, TITLELABEL_H * SCREEN_HEIGHT)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:24.0f]];
    [self.view addSubview:titleLabel];
    
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setFrame:CGRectMake(BACKBUTTON_X, BACKBUTTON_Y * SCREEN_HEIGHT, BACKBUTTON_W, BACKBUTTON_H * SCREEN_HEIGHT)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickOnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
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

@end
