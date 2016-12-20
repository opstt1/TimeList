//
//  TaskDataSource+Func.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/20.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskDataSource.h"

@interface TaskDataSource (Func)

- (void)addTaskModel:(TaskModel *)taskModel;

- (void)insertModel:(TaskModel *)taskModel;

- (void)insertAtIndex:(NSInteger)index model:(TaskModel *)taskModel;

- (NSInteger)count;

- (TaskModel *)objectAtInde:(NSUInteger)index;

- (void)dataSourceHasDoneAtIndex:(NSInteger)index;

- (void)deleteAtIndex:(NSInteger)index;

- (void)dataSourceWithArray:(NSArray *)array;


@end
