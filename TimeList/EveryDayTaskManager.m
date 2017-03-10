//
//  EveryDayTaskManager.m
//  TimeList
//
//  Created by LiHaomiao on 2017/3/9.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EveryDayTaskManager.h"
#import "TaskModel+EveryDayUseFMDB.h"

@implementation EveryDayTaskManager

+ (EveryDayTaskManager *)shareManager
{
    static EveryDayTaskManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EveryDayTaskManager alloc] init];
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
    [TaskModel everyDayCreatSqliteTable];
    [_dataSource dataSourceWithArray:[TaskModel everyDayTaskFindAllData]];
    
    return self;
}
@end
