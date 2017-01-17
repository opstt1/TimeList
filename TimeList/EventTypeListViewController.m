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
#import "EventTypeModel+FMDB.h"

@interface EventTypeListViewController ()<UITableViewDelegate,UITableViewDataSource,TLDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, readwrite, assign) BOOL isCreateEvenType;


@end

@implementation EventTypeListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpRightNavigationButtonWithTitle:@"+" tintColor:COLOR_666666];
    [EventTypeManager shareManager].delegate = self;
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[EventTypeManager shareManager] count];
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
    [cell configWithData:[[EventTypeManager shareManager] objectAtInde:indexPath.row] deleteBlock:^(id result) {
        
        [[EventTypeManager shareManager] deleteAtIndex:indexPath.row];
    } editBlock:^(id result) {
        NSLog(@"edti");
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventTypeModle *model = [[EventTypeManager shareManager] objectAtInde:indexPath.row];
    if ( self.bvcBlock ){
        self.bvcBlock(model);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - action

- (void)rightNavigationButtonTapped:(id)sender
{
    self.isCreateEvenType = YES;
    [self.tableView reloadData];
    [CreateEvenTypeView createWithComplete:^(EventTypeModel *model) {
        if ( model != nil ){
            [model insertSQL];
            [[EventTypeManager shareManager] insertmodel:model];
        }
        _isCreateEvenType = NO;
        [self.tableView reloadData];
    }];
}

#pragma mark - TLDataSourceDelegate

- (void)TLDataSource:(TLDataSource *)dataSource update:(BOOL)update
{
    if ( update ){
        [self.tableView reloadData];
    }
}

@end
