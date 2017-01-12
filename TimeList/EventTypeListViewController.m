//
//  EventTypeListViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeListViewController.h"
#import "EventTypeManager.h"
#import "Constants.h"
#import "EventTypeCell.h"

@interface EventTypeListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EventTypeListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [EventTypeManager shareManager];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [EventTypeManager shareManager].eventTypes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return defautlCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"Cell";
    EventTypeCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if ( !cell ){
        cell = [[EventTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    [cell configWithData:[EventTypeManager shareManager].eventTypes[indexPath.row] deleteBlock:^(id result) {
        
    } editBlock:^(id result) {
        
    }];
    return cell;
}



@end
