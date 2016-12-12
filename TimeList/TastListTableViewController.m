//
//  TastListTableViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TastListTableViewController.h"
#import "TaksDataSuorce.h"

@interface TastListTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, readwrite, strong) TaksDataSuorce *dataSource;


@end

@implementation TastListTableViewController


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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"Cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if ( !cell ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    return cell;
}
@end
