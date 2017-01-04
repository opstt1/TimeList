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
#import "DailySummaryViewController.h"
#import "DailySummaryDataSource+FMDB.h"
#import "TaskAlwaysUseViewController.h"

@interface TaskListTableViewController ()<UITableViewDelegate,UITableViewDataSource,TaskListTableViewCellDelegate,TaskDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, readwrite, strong) TaskDataSource *dataSource;
@property (nonatomic, readwrite, strong) DailySummaryDataSource *dailySummaryDataSource;


@end

@implementation TaskListTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self p_addDailySummaryButtton];
    NSLog(@"viewDidLoad");
}

- (void)configWithData:(TaskDataSource *)dataSource dailySummaryDataSource:(DailySummaryDataSource *)dailySummaryDataSource
{
    _dailySummaryDataSource = dailySummaryDataSource;
    [self configWithData:dataSource];
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

#pragma mark - DailySummary

//添加每日总结button
- (void)p_addDailySummaryButtton
{
    UIButton *dailySummaryButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-70, UISCREEN_HEIGHT-125, 50, 50)];
    dailySummaryButton.layer.cornerRadius = 25.0f;
    dailySummaryButton.layer.shadowColor = [UIColor blackColor].CGColor;
    dailySummaryButton.layer.shadowOffset =  CGSizeMake(1, 0.5);
    dailySummaryButton.layer.shadowOpacity = 0.8;
    dailySummaryButton.backgroundColor = [UIColor redColor];
    [dailySummaryButton setTitle:@"总结" forState:UIControlStateNormal];
    [dailySummaryButton addTarget:self action:@selector(didTapDailySummaryButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailySummaryButton];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(70, UISCREEN_HEIGHT-125, 40, 40)];
    button.layer.cornerRadius = 20.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset =  CGSizeMake(1, 0.5);
    button.layer.shadowOpacity = 0.8;
    [button.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [button.titleLabel setNumberOfLines:2];
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"添加\n常用" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapAlawysUseTasButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)didTapDailySummaryButton:(id)sender
{
    DailySummaryViewController *vc = [[UIStoryboard storyboardWithName:@"Summary" bundle:nil] instantiateViewControllerWithIdentifier:@"DailySummaryViewController"];
    [vc data:_dailySummaryDataSource complete:^(BOOL complete) {
        
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didTapAlawysUseTasButton:(UIButton *)sender
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
        [strong_weak_self.dataSource insertModel:model];
        return YES;
    };
    [self.navigationController pushViewController:vc animated:YES];
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
