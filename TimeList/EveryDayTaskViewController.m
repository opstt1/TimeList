//
//  EveryDayTaskViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/3/7.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EveryDayTaskViewController.h"
#import "TaskDetailViewController.h"
#import "EveryDayTaskManager.h"
#import "TaskListTableViewCell.h"
#import "Constants.h"
#import "TaskModel+EveryDayUseFMDB.h"

@interface EveryDayTaskViewController ()<UITableViewDelegate,UITableViewDataSource,TLDataSourceDelegate,TaskListTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@end

@implementation EveryDayTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpRightNavigationButtonWithTitle:@"添加" tintColor:nil];
    [EveryDayTaskManager shareManager].dataSource.delegate = self;
    [self detectionNewTask];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)rightNavigationButtonTapped:(id)sender
{
    TaskDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    WEAK_OBJ_REF(self);
    [vc createComplete:^(TaskModel *model) {
        STRONG_OBJ_REF(weak_self);
        if ( !strong_weak_self ) return;
        [model everyDayTaskInsertSQL];
        [[EveryDayTaskManager shareManager].dataSource insertmodel:model];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[EveryDayTaskManager shareManager] dataSource].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"Cell";
    TaskListTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if ( !cell ){
        cell = [[TaskListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    [cell configWithData:[[EveryDayTaskManager shareManager].dataSource objectAtInde:indexPath.section] indexPath:indexPath delegateTarget:self];
    cell.canSlideToLeft = NO;
    cell.sideslipRightLimitMargin = 0.0f;
    return cell;
}

#pragma mark - 

//检测是否有没有新的任务，没有添加到今日认为中
- (void)detectionNewTask
{
    for ( TaskModel *model in [EveryDayTaskManager shareManager].dataSource.dataList ){
        if ( model.startTime == nil || ![model.startTime isSameDay:[NSDate date]] ){
            _tableViewBottom.constant = 60.0f;
            return;
        }
    }
    _tableViewBottom.constant = 0.0f;
}

#pragma mark - TaskDataSourceDelegate
- (void)TLDataSource:(TLDataSource *)dataSource update:(BOOL)update
{
    if ( update ){
        [self detectionNewTask];
        [self.tableView reloadData];
    }
}

#pragma mark - TaskListTableViewCellDelegate
- (void)taskListTableViewCell:(TaskListTableViewCell *)cell cellDidTapEditAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (void)taskListTableViewCell:(TaskListTableViewCell *)cell cellDidTapDeleteAtIndexPath:(NSIndexPath *)indexPath
{
    TaskModel *deletModel = (TaskModel *)[[EveryDayTaskManager shareManager].dataSource deleteAtIndex:indexPath.section];
    [deletModel everyDayTaskRemoveSQL];
}
@end
