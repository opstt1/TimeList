//
//  TastListTableViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskListTableViewController.h"
#import "TaskDataSource+Func.h"
#import "TaskListTableViewCell.h"
#import "TaskDetailViewController.h"
#import "Constants.h"
#import "Toolkit.h"
#import "TaskModel+FMDB.h"

@interface TaskListTableViewController ()<UITableViewDelegate,UITableViewDataSource,TaskListTableViewCellDelegate,TaskDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, readwrite, strong) TaskDataSource *dataSource;


@end

@implementation TaskListTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    NSLog(@"viewDidLoad");
}

- (void)configWithData:(TaskDataSource *)dataSource
{
    _dataSource = dataSource;
    _dataSource.delegate = self;
    [self.tableView reloadData];
    NSLog(@"config");
}

- (void)updateViewController
{
    [self.tableView reloadData];
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
    [_dataSource dataSourceHasDoneAtIndex:indexPath.section];
    
    if ( !needSumary ){
        return;
    }
    
    [self navigationToTaskDetialWithType:TaskDetail_Summary taskModel:[_dataSource objectAtInde:indexPath.section]];
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

- (void)navigationToTaskDetialWithType:(TaskDetailType)type taskModel:(TaskModel *)taskModel
{
    TaskDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    WEAK_OBJ_REF(self);
    TaskDetailBlock comlete = ^(TaskModel *model){
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
