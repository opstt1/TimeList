//
//  FirstViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "FirstViewController.h"
#import "TaskListTableViewController.h"
#import "TaskListSessionManager.h"
#import "TaskDetailViewController.h"
#import "Constants.h"
#import "TaskDataSource+Func.h"
#import "TaskDetailPushAnimatedTransitioning.h"
#import "TaskModel+FMDB.h"
#import "DailySummaryViewController.h"
#import "DailySummaryDataSource+FMDB.h"
#import "TaskAlwaysUseViewController.h"
#import "TaskListTableViewCell.h"
#import "EveryDayTaskViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,TaskListTableViewCellDelegate,TaskDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, readwrite, strong) TaskDataSource *dataSource;
@property (nonatomic, readwrite, strong) DailySummaryDataSource *dailySummaryDataSource;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRightNavigationButtonWithTitle:@"排序" tintColor:[UIColor blackColor]];
    [self setUpLeftNavigationButtonWithTitle:@"+" tintColor:nil];
    
    _dailySummaryDataSource = [[TaskListSessionManager sharedManager] dailySummaryDataSource];
    _dataSource = [[TaskListSessionManager sharedManager] dataSource];
    _dataSource.delegate = self;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self p_addDailySummaryButtton];
    
    self.pushAnimationTransition = [TaskDetailPushAnimatedTransitioning new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate=self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.delegate = nil;
}

#pragma mark - DailySummary

//添加每日总结button
- (void)p_addDailySummaryButtton
{
    UIButton *addTaskButton = [[UIButton alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT-60, UISCREEN_WIDTH/3, 60)];
    addTaskButton.backgroundColor = [UIColor blackColor];
    [addTaskButton setTitle:@"添加任务" forState:UIControlStateNormal];
    [addTaskButton addTarget:self action:@selector(didTapAddTaskButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addTaskButton];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/3, UISCREEN_HEIGHT-60, UISCREEN_WIDTH/3, 60)];
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"常用任务" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapAlawysUseTaskButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *daysTaskButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/3*2, UISCREEN_HEIGHT-60.0f, UISCREEN_WIDTH/3, 60.0f)];
    daysTaskButton.backgroundColor = [UIColor blackColor];
    [daysTaskButton setTitle:@"每日任务列表" forState:UIControlStateNormal];
    [daysTaskButton addTarget:self action:@selector(didTapDaysTaskButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:daysTaskButton];
    
}

- (void)didTapDaysTaskButton:(UIButton *)button
{
    EveryDayTaskViewController *vc = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateViewControllerWithIdentifier:@"EveryDayTaskViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

//跳转到常使用任务
- (void)didTapAlawysUseTaskButton:(UIButton *)sender
{
    TaskAlwaysUseViewController *vc = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateViewControllerWithIdentifier:@"TaskAlwaysUseViewController"];
    
    WEAK_OBJ_REF(self);
    vc.selectCompelet = ^(id result){
        STRONG_OBJ_REF(weak_self);
        if( !strong_weak_self ){
            return NO;
        }
        TaskModel *model = result;
        [model createSuccess];
        if ( [strong_weak_self.dataSource count] > 0 ){
            [strong_weak_self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        [strong_weak_self.dataSource insertModel:model];
        return YES;
    };
    self.selectRect = sender.frame;
    [self pushViewController:vc animated:YES useCustomAnimation:NO];
}

#pragma mark - action

//点击创建一个任务
- (void)didTapAddTaskButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Task" bundle:nil];
    
    TaskDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    WEAK_OBJ_REF(self);
    [vc createComplete:^(TaskModel *model) {
        STRONG_OBJ_REF(weak_self);
        if ( strong_weak_self ){
            [model createSuccess];
            [(TaskDataSource *)[[TaskListSessionManager sharedManager] dataSource] insertModel:model];
        }
    }];
    self.selectRect = CGRectMake(30, 30, 5, 5);
    [self pushViewController:vc animated:YES useCustomAnimation:NO];
}

#pragma mark - UITable

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ( !_dataSource ){
        return 0;
    }
    return [_dataSource count];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    [cell configWithData:[_dataSource objectAtInde:indexPath.section] indexPath:indexPath delegateTarget:self];
    
    return cell;
}

#pragma mark - TaskListTableViewCellDelegate

//点击了完成 或者总结
- (void)taskListTableViewCell:(TaskListTableViewCell *)cell cellDidTapDoneAtIndexPath:(NSIndexPath *)indexPath needSummary:(BOOL)needSumary
{
    TaskModel *model = [_dataSource objectAtInde:indexPath.section];
    [_dataSource dataSourceHasDoneAtIndex:indexPath.section];
    
    if ( !needSumary ){
        return;
    }
    
    [self navigationToTaskDetialWithType:TaskDetail_Summary taskModel:model];
}

//点击了删除功能
- (void)taskListTableViewCell:(TaskListTableViewCell *)cell cellDidTapDeleteAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataSource deleteAtIndex:indexPath.section];
}

//点击了编辑修改功能
- (void)taskListTableViewCell:(TaskListTableViewCell *)cell cellDidTapEditAtIndexPath:(NSIndexPath *)indexPath
{
    [self navigationToTaskDetialWithType:TaskDetail_Update taskModel:[_dataSource objectAtInde:indexPath.section]];
}

#pragma mark - TaskDataSourceDelegate

- (void)taskDataSource:(TaskDataSource *)taskDataSource update:(BOOL)update
{
    if ( update ){
        [self.tableView reloadData];
    }
}

#pragma mark - turn

//跳转到任务详情页面
- (void)navigationToTaskDetialWithType:(TaskDetailType)type taskModel:(TaskModel *)taskModel
{
    TaskDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    WEAK_OBJ_REF(self);
    TaskDetailBlock comlete = ^(TaskModel *model){
        [model upadteSQL];
        STRONG_OBJ_REF(weak_self);
        if ( strong_weak_self ){
            [strong_weak_self.tableView reloadData];
        }
    };
    switch (type) {
        case TaskDetail_Update:{
            [vc updateTask:taskModel complete:comlete];
            break;
        }
        case TaskDetail_Summary:{
            [vc summaryTask:taskModel complete:comlete];
        }
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
