//
//  TaksDataSuorce.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaksDataSuorce.h"
#import "TaskModel.h"

@interface TaksDataSuorce()

@property (nonatomic, readwrite, copy) NSArray *taskList;

@end

@implementation TaksDataSuorce

+ (TaksDataSuorce *)creatTaksDataWithDate:(NSDate *)date
{
    TaksDataSuorce *dataSource = [[TaksDataSuorce alloc] init];
    //通过日期获取本地数据库数据,然后更新list
    //
    //
    return dataSource;
}

- (instancetype)init
{
    self = [super init];
    if ( !self ) return nil;
    
    _taskList = [NSArray new];
    return self;
}


- (void)addTaskModel:(TaskModel *)taskModel
{
    if ( !taskModel || ![taskModel dataIntegrity] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_taskList];
    [array addObject:taskModel];
    
    self.taskList = [NSArray arrayWithArray:array];
}

- (void)insertModel:(TaskModel *)taskModel
{
    [self insertAtIndex:0 model:taskModel];
}

- (void)insertAtIndex:(NSInteger)index model:(TaskModel *)taskModel
{
    if ( index < 0 || index >= _taskList.count ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_taskList];
    [array insertObject:taskModel atIndex:index];
    _taskList = [NSArray arrayWithArray:array];
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


@end
