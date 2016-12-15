//
//  TaskListSessionManager.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskListSessionManager.h"
#import "TaksDataSuorce.h"
#import "TaskModel.h"

@interface TaskListSessionManager()

@property (nonatomic, readwrite, strong) TaksDataSuorce *dataSource;

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
    
    _dataSource = [TaksDataSuorce creatTaksDataWithDate:[NSDate date]];
    
    [self addDatajia];
    
    return self;
}


- (void)addDatajia
{
    TaskModel *moede1 = [[TaskModel alloc] init];
    moede1.title = @"吃饭";
    moede1.status = TaskUndone;
    moede1.importance = 5;
    
    [_dataSource addTaskModel:moede1];
    
    TaskModel *moede2 = [[TaskModel alloc] init];
    moede2.title = @"打架";
    moede2.status = TaskUndone;
    moede2.importance = 10;
    
    [_dataSource addTaskModel:moede2];
    
    TaskModel *moede3 = [[TaskModel alloc] init];
    moede3.title = @"吹牛";
    moede3.status = TaskUndone;
    moede3.importance = 1;
    
    [_dataSource addTaskModel:moede3];
}


- (TaksDataSuorce *)dataSource
{
    return _dataSource;
}

@end
