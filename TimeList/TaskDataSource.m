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

@property (nonatomic, readwrite, copy) NSArray *taskList;

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


- (void)addTaskModel:(TaskModel *)taskModel
{
    if ( !taskModel || ![taskModel dataIntegrity] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_taskList];
    [array addObject:taskModel];
    [self p_setTaskList:array];
}

- (void)insertModel:(TaskModel *)taskModel
{
    [self insertAtIndex:0 model:taskModel];
}

- (void)insertAtIndex:(NSInteger)index model:(TaskModel *)taskModel
{
    if ( [_taskList isOutArrayRangeAtIndex:index] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_taskList];
    [array insertObject:taskModel atIndex:index];
    
    [self p_setTaskList:array];
    
}


- (void)moveObjectFromeIndex:(NSInteger)fromeIndex toIndex:(NSInteger)toIndex
{
    if ( [_taskList isOutArrayRangeAtIndex:fromeIndex] || [_taskList isOutArrayRangeAtIndex:toIndex] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_taskList];
    TaskModel *model = array[fromeIndex];
    [array removeObjectAtIndex:fromeIndex];
    [array insertObject:model atIndex:toIndex];
    [self p_setTaskList:array];
}

- (void)deleteAtIndex:(NSInteger)index
{
    if ( _taskList.count == 0 || [_taskList isOutArrayRangeAtIndex:index] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_taskList];
    TaskModel *removeModel = [array objectAtIndex:index];
    [removeModel remove];
    [array removeObjectAtIndex:index];
    [self p_setTaskList:array];
}

- (NSInteger)count
{
    return _taskList.count;
}

- (TaskModel *)objectAtInde:(NSUInteger)index
{
    if( index >= _taskList.count ){
        return nil;
    }
    return  [_taskList objectAtIndex:index];
}

- (void)dataSourceWithArray:(NSArray *)array
{
    [self p_setTaskList:array];
}

- (void)p_setTaskList:(NSArray *)taskList
{
    _taskList = [NSArray arrayWithArray:taskList];
    [self p_dataUpdate];
}

- (void)p_dataUpdate
{
    if ( _delegate && [_delegate respondsToSelector:@selector(taskDataSource:update:)] ){
        [_delegate taskDataSource:self update:YES];
    }
}


#pragma mark - 

- (void)dataSourceHasDoneAtIndex:(NSInteger)index
{
    if ( index < 0 || index >= _taskList.count ){
        return;
    }
    TaskModel *hasDoneModel = [_taskList objectAtIndex:index];
    hasDoneModel.status = TaskHasBeenDone;
    [hasDoneModel upadteSQL];
    for ( int i = (int)index + 1; i < _taskList.count; ++i ){
        TaskModel *model = _taskList[i];
        if ( model.status == TaskHasBeenDone ){
            if ( i == index + 1 ){
                [self p_dataUpdate];
                return;
            }
            [self moveObjectFromeIndex:index toIndex:i-1];
            return;
        }
    }
    [self moveObjectFromeIndex:index toIndex:_taskList.count-1];
}

@end
