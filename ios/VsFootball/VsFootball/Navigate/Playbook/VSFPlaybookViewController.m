//
//  VSFPlaybookViewController.m
//  VsFootball
//
//  Created by hjy on 7/25/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFPlaybookViewController.h"
#import "VSFFeedBackViewController.h"
#import "VSFHomeViewController.h"
#import "DDMenuController.h"
#import "VSFAppDelegate.h"
#import "VSFADBannerView.h"
#import "VSFLoginViewController.h"

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
        playbookDataList = [NSArray arrayWithObjects:@"Game List", @"Career Stats", @"Vs. Sports Store", @"Feedback", @"Help",@"Sign out", nil];
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
    DDMenuController *menuController = (DDMenuController *)((VSFAppDelegate *)[[UIApplication sharedApplication] delegate]).menuController;
    menuController.leftViewController = self;
    VSFHomeViewController *homeViewController = [[VSFHomeViewController alloc] init];
    VSFFeedBackViewController *feedBackViewController = [[VSFFeedBackViewController alloc] init];
    VSFLoginViewController *loginViewController = [[VSFLoginViewController alloc] init];
    UINavigationController *navController;
    switch (indexPath.row) {
        case 0:
            navController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
            [menuController setRootController:navController animated:YES];
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            navController = [[UINavigationController alloc] initWithRootViewController:feedBackViewController];
            [menuController setRootController:navController animated:YES];
            break;
        case 4:
            break;
        case 5:
            navController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
            [menuController setRootController:navController animated:YES];
            break;
        default:
            break;
    }

    [VSFADBannerView getAdBannerView].frame = CGRectMake(0, SCREEN_HEIGHT - 20 - 44, 320, 50);
    [menuController.view addSubview:[VSFADBannerView getAdBannerView]];

}

@end
