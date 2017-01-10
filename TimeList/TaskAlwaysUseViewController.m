//
//  TaskAlwaysUseViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/30.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskAlwaysUseViewController.h"
#import "TaskAlwaysUseManager.h"
#import "TaskListTableViewCell.h"
#import "TaskDetailViewController.h"
#import "Constants.h"
#import "TaskModel+AlwaysUseFMDB.h"

@interface TaskAlwaysUseViewController ()<UITableViewDelegate,UITableViewDataSource,TLDataSourceDelegate,TaskListTableViewCellDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TaskAlwaysUseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TaskAlwaysUseManager shareManager].dataSource.delegate = self;
    [self setUpRightNavigationButtonWithTitle:@"+" tintColor:[UIColor blackColor]];
    [self addBackGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[TaskAlwaysUseManager shareManager] dataSource].count;
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
    [cell configWithData:[[TaskAlwaysUseManager shareManager].dataSource objectAtInde:indexPath.section] indexPath:indexPath delegateTarget:self];
    cell.canSlideToLeft = NO;
    cell.sideslipRightLimitMargin = 0.0f;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskModel *model = [[TaskAlwaysUseManager shareManager].dataSource objectAtInde:indexPath.section];
    TaskModel *modelCopy = [model copy];
    if ( _selectCompelet ){
        if(  _selectCompelet(modelCopy) ){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - action

- (void)rightNavigationButtonTapped:(id)sender
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Task" bundle:nil];
    
    TaskDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    WEAK_OBJ_REF(self);
    [vc createComplete:^(TaskModel *model) {
        STRONG_OBJ_REF(weak_self);
        if ( strong_weak_self ){
            [model alwaysInsertSQL];
            [[TaskAlwaysUseManager shareManager].dataSource insertmodel:model];
        }
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - TaskDataSourceDelegate

- (void)TLDataSource:(TLDataSource *)dataSource update:(BOOL)update
{
    if ( update ){
        [self.tableView reloadData];
    }
}

#pragma mark - TaskListTableViewCellDelegate

- (void)taskListTableViewCell:(TaskListTableViewCell *)cell cellDidTapDeleteAtIndexPath:(NSIndexPath *)indexPath
{
    TaskModel *deletModel = (TaskModel *)[[TaskAlwaysUseManager shareManager].dataSource deleteAtIndex:indexPath.section];
    [deletModel alwaysRemoveSQL];
}

- (void)taskListTableViewCell:(TaskListTableViewCell *)cell cellDidTapEditAtIndexPath:(NSIndexPath *)indexPath
{
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Task" bundle:nil];
    TaskDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    WEAK_OBJ_REF(self);
    [vc updateTask:[[TaskAlwaysUseManager shareManager].dataSource objectAtInde:indexPath.section] complete:^(TaskModel *model) {
        STRONG_OBJ_REF(weak_self);
        if ( strong_weak_self ){
            [model alwaysUpadteSQL];
            [strong_weak_self.tableView reloadData];
        }
    }];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
