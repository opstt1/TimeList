//
//  EventTypeSelectView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/17.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeSelectView.h"
#import "Constants.h"
#import "EventTypeManager.h"
#import "EventTypeCell.h"

@interface EventTypeSelectView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, readwrite, strong) UITableView *tableView;

@end

@implementation EventTypeSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( !self ){
        return nil;
    }
    [self initView];
    return self;
}



- (void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    _tableView.y = 0;
    [self addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.clipsToBounds = YES;
}


#pragma mark -

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
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    EventTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( !cell ){
        cell = [[EventTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithData:[[EventTypeManager shareManager] objectAtInde:indexPath.row] deleteBlock:nil editBlock:nil];
    [cell enableEdit:NO];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventTypeModle *model = [[EventTypeManager shareManager] objectAtInde:indexPath.row];
    if ( self.bvBlock ){
        self.bvBlock(model);
    }
}

@end
