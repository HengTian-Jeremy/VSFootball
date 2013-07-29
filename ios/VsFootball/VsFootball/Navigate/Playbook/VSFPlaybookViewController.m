//
//  VSFPlaybookViewController.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlaybookViewController.h"

#define PLAYBOOKTABLEVIEW_X 0
#define PLAYBOOKTABLEVIEW_Y 0
#define PLAYBOOKTABLEVIEW_W self.view.frame.size.width - 100
#define PLAYBOOKTABLEVIEW_H self.view.frame.size.height

@interface VSFPlaybookViewController (){
    int selectIdnex;
    NSArray *playbookDataList;
    NSArray *storeDataList;
}

- (void)initUI;

@end

@implementation VSFPlaybookViewController

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
        playbookDataList = [NSArray arrayWithObjects:@"Game List", @"Career Stats", @"Vs. Sports Store", @"Feedback", @"Help", nil];
//        storeDataList = [NSArray arrayWithObjects:@"21",@"22",@"23",@"24", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
- (void)initUI
{
    playbooktableView = [[UITableView alloc] init];
    playbooktableView.frame = CGRectMake(PLAYBOOKTABLEVIEW_X, PLAYBOOKTABLEVIEW_Y, PLAYBOOKTABLEVIEW_W, PLAYBOOKTABLEVIEW_H);
    playbooktableView.delegate = self;
    playbooktableView.dataSource = self;
    playbooktableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:playbooktableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return playbookDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"playbookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.text = [playbookDataList objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
