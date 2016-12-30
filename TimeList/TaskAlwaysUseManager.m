//
//  TaskAlwaysUseManager.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/30.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskAlwaysUseManager.h"
#import "TaskModel+AlwaysUseFMDB.h"

@interface TaskAlwaysUseManager()

@end

@implementation TaskAlwaysUseManager


+ (TaskAlwaysUseManager *)shareManager
{
    static TaskAlwaysUseManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TaskAlwaysUseManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if ( !self ){
        return nil;
    }
    
    _dataSource = [[TLDataSource alloc] init];
    [TaskModel alwaysCreateSqliteTable];
    
    NSArray *array = [TaskModel alwaysFindAllData];
    [_dataSource dataSourceWithArray:array];
    
    return self;
}


@end
