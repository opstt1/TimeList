//
//  TaksDataSuorce.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskDataSource.h"
#import "TaskModel+FMDB.h"
#import "Toolkit.h"
#import "FMDatabase.h"
#import "TaskDataSource+Sort.h"

@interface TaskDataSource()

//@property (nonatomic, readwrite, copy) NSArray *taskList;

@end

@implementation TaskDataSource

+ (TaskDataSource *)creatTaksDataWithDate:(NSDate *)date
{
    TaskDataSource *dataSource = [[TaskDataSource alloc] init];
    //通过日期获取本地数据库数据,然后更新list
    //
    //
    NSDate *begin = [date beginningOfDay];
    NSDate *end = [date endOfDay];   NSArray *array =  [TaskModel findOfStartDate:begin toDate:end];
    dataSource.taskList = [NSArray arrayWithArray:array];
    [dataSource sortDefault];
    return dataSource;
}

- (instancetype)init
{
    self = [super init];
    if ( !self ) return nil;
    
    _taskList = [NSArray new];
    
    [TaskModel createSqliteTable];
    return self;
}

- (void)p_dataUpdate
{
    if ( _delegate && [_delegate respondsToSelector:@selector(taskDataSource:update:)] ){
        [_delegate taskDataSource:self update:YES];
    }
}


#pragma mark - 



@end
