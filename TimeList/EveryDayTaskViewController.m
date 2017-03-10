//
//  EveryDayTaskViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/3/7.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EveryDayTaskViewController.h"
#import "TaskDetailViewController.h"

@interface EveryDayTaskViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EveryDayTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpRightNavigationButtonWithTitle:@"添加" tintColor:nil];
}

- (void)rightNavigationButtonTapped:(id)sender
{
    TaskDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
