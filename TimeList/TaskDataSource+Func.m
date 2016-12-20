//
//  TaskDataSource+Func.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/20.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskDataSource+Func.h"
#import "TaskModel+FMDB.h"
#import "Toolkit.h"

@implementation TaskDataSource (Func)

- (void)addTaskModel:(TaskModel *)taskModel
{
    if ( !taskModel || ![taskModel dataIntegrity] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.taskList];
    [array addObject:taskModel];
    [self p_setTaskList:array];
}

- (void)insertModel:(TaskModel *)taskModel
{
    [self insertAtIndex:0 model:taskModel];
}

- (void)insertAtIndex:(NSInteger)index model:(TaskModel *)taskModel
{
    if ( [self.taskList isOutArrayRangeAtIndex:index] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.taskList];
    [array insertObject:taskModel atIndex:index];
    
    [self p_setTaskList:array];
    
}


- (void)moveObjectFromeIndex:(NSInteger)fromeIndex toIndex:(NSInteger)toIndex
{
    if ( [self.taskList isOutArrayRangeAtIndex:fromeIndex] || [self.taskList isOutArrayRangeAtIndex:toIndex] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.taskList];
    TaskModel *model = array[fromeIndex];
    [array removeObjectAtIndex:fromeIndex];
    [array insertObject:model atIndex:toIndex];
    [self p_setTaskList:array];
}

- (void)deleteAtIndex:(NSInteger)index
{
    if ( self.taskList.count == 0 || [self.taskList isOutArrayRangeAtIndex:index] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.taskList];
    TaskModel *removeModel = [array objectAtIndex:index];
    [removeModel remove];
    [array removeObjectAtIndex:index];
    [self p_setTaskList:array];
}

- (NSInteger)count
{
    return self.taskList.count;
}

- (TaskModel *)objectAtInde:(NSUInteger)index
{
    if( index >= self.taskList.count ){
        return nil;
    }
    return  [self.taskList objectAtIndex:index];
}

- (void)dataSourceWithArray:(NSArray *)array
{
    [self p_setTaskList:array];
}

- (void)p_setTaskList:(NSArray *)taskList
{
    self.taskList = [NSArray arrayWithArray:taskList];
    [self p_dataUpdate];
}


- (void)dataSourceHasDoneAtIndex:(NSInteger)index
{
    if ( index < 0 || index >= self.taskList.count ){
        return;
    }
    TaskModel *hasDoneModel = [self.taskList objectAtIndex:index];
    hasDoneModel.status = TaskHasBeenDone;
    [hasDoneModel upadteSQL];
    for ( int i = (int)index + 1; i < self.taskList.count; ++i ){
        TaskModel *model = self.taskList[i];
        if ( model.status == TaskHasBeenDone ){
            if ( i == index + 1 ){
                [self p_dataUpdate];
                return;
            }
            [self moveObjectFromeIndex:index toIndex:i-1];
            return;
        }
    }
    [self moveObjectFromeIndex:index toIndex:self.taskList.count-1];
}

@end
