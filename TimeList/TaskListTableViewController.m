//
//  TastListTableViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskListTableViewController.h"
#import "TaksDataSuorce.h"
#import "TaskListTableViewCell.h"

@interface TaskListTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, readwrite, strong) TaksDataSuorce *dataSource;


@end

@implementation TaskListTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    NSLog(@"viewDidLoad");
}

- (void)configWithData:(TaksDataSuorce *)dataSource
{
    _dataSource = dataSource;
    NSLog(@"config");
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
    return 5;
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
    return cell;
}
@end
