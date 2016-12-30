//
//  TaskListSessionManager.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskListSessionManager.h"
#import "TaskDataSource.h"
#import "TaskModel.h"
#import "DailySummaryDataSource.h"

@interface TaskListSessionManager()

@property (nonatomic, readwrite, strong) TaskDataSource *dataSource;
@property (nonatomic, readwrite, strong) DailySummaryDataSource *dailySummaryDateSource;

@end

@implementation TaskListSessionManager


+ (instancetype)sharedManager
{
    static TaskListSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TaskListSessionManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if ( !self ) return nil;
    
    _dataSource = [TaskDataSource creatTaksDataWithDate:[NSDate date]];
    _dailySummaryDateSource = [DailySummaryDataSource createWithDate:[NSDate date]];
    return self;
}



- (TaskDataSource *)dataSource
{
    return _dataSource;
}

- (DailySummaryDataSource *)dailySummaryDataSource
{
    return _dailySummaryDateSource;
}

@end
