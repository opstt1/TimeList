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
#import "CreateEvenTypeView.h"
#import "EventTypeModle+FMDB.h"

@interface EventTypeListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, readwrite, assign) BOOL isCreateEvenType;


@end

@implementation EventTypeListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpRightNavigationButtonWithTitle:@"+" tintColor:COLOR_666666];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( self.isCreateEvenType ){
        return 44.0f;
    }
    return 0.01f;
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

#pragma mark - action

- (void)rightNavigationButtonTapped:(id)sender
{
    self.isCreateEvenType = YES;
    [self.tableView reloadData];
    [CreateEvenTypeView createWithComplete:^(EventTypeModle *model) {
        if ( model != nil ){
            [model insertSQL];
            [[EventTypeManager shareManager] insertEventModle:model];
        }
        _isCreateEvenType = NO;
        [self.tableView reloadData];
    }];
}


@end
