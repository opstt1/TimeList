//
//  SecondViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "SecondViewController.h"
#import "HourlyRecordCreateView.h"
#import "HourlyRecordModel+FMDB.h"
#import "HourlyRecordCell.h"
#import "Constants.h"
#import "HourlyRecordAnalyzeViewController.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,TLDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, readwrite, strong) HourlyRecordDataSource *dataSource;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLeftNavigationButtonWithTitle:@"+" tintColor:nil];
    [self setUpRightNavigationButtonWithTitle:@"统计" tintColor:nil];
    self.dataSource = [HourlyRecordDataSource createWithDate:[NSDate date]];
    
    self.dataSource.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)leftNavigationButtonTapped:(id)sender
{
    NSDate *lastEndDate =((HourlyRecordModel*)[self.dataSource objectAtInde:0]).endDate;
    WEAK_OBJ_REF(self);
    [HourlyRecordCreateView createWithStartDate:lastEndDate complete:^(HourlyRecordModel *model) {
        STRONG_OBJ_REF(weak_self);
        if ( strong_weak_self ){
            [model insertSQL];
            [strong_weak_self.dataSource insertmodel:model];
            [strong_weak_self tableViewReload];
        }
    }];;
}

- (void)rightNavigationButtonTapped:(id)sender
{
    HourlyRecordAnalyzeViewController *vc = [[UIStoryboard storyboardWithName:@"Analyze" bundle:nil] instantiateViewControllerWithIdentifier:@"HourlyRecordAnalyzeViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"header";
    UITableViewHeaderFooterView *header = [_tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if ( !header ){
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentifier];
    }
    HourlyRecordModel *model = [_dataSource objectAtInde:section];
    header.textLabel.text = [NSString stringWithFormat:@"%@ --- %@",model.startTime,model.endTime];
    return header;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.font = [UIFont systemFontOfSize:15.0f];
    header.textLabel.textColor = [UIColor orangeColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HourlyRecordModel *model = [_dataSource objectAtInde:indexPath.section];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"Cell";
    HourlyRecordCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if ( !cell ){
        cell = [[HourlyRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    WEAK_OBJ_REF(self);
    [cell configWithData:[_dataSource objectAtInde:indexPath.section] deleteBlock:^(id result) {
        STRONG_OBJ_REF(weak_self);
        if  ( strong_weak_self){
            HourlyRecordModel *model = [strong_weak_self.dataSource deleteAtIndex:indexPath.section];
            [model removeSQL];
        }
    } editBlock:^(id result) {
        STRONG_OBJ_REF(weak_self);
        if  ( strong_weak_self){
            [strong_weak_self editHourlyRecordWitIndex:indexPath.section];
        }
    }];
    
    return cell;

}

#pragma mark - 

- (void)editHourlyRecordWitIndex:(NSInteger)index
{
    HourlyRecordModel *model = [_dataSource objectAtInde:index];
    
    NSDate *lastEndDate = (index == _dataSource.count - 1 ) ? nil :((HourlyRecordModel*)[self.dataSource objectAtInde:index+1]).endDate;
    [HourlyRecordCreateView editWithModel:model allowEarlyStartDate:lastEndDate complete:^(HourlyRecordModel *model) {
        [model upadteSQL];
        [self tableViewReload];
    }];
    
}

#pragma mark - TLDataSourceDelegate
//数据更新
- (void)TLDataSource:(TLDataSource *)dataSource update:(BOOL)update
{
    if ( update ){
        [_tableView reloadData];
    }
}

#pragma mark - updateTableView
- (void)tableViewReload
{
    [_dataSource sortStartDateIsAscending:NO];
}
@end
