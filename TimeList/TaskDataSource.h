//
//  TaksDataSuorce.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskModel;

@class TaskDataSource;

@protocol TaskDataSourceDelegate <NSObject>

@optional
- (void)taskDataSource:(TaskDataSource *)taskDataSource update:(BOOL)update;

@end

@interface TaskDataSource : NSObject

@property (nonatomic, readwrite, weak) id<TaskDataSourceDelegate> delegate;

+ (TaskDataSource *)creatTaksDataWithDate:(NSDate *)date;

- (void)addTaskModel:(TaskModel *)taskModel;

- (void)insertModel:(TaskModel *)taskModel;
- (void)insertAtIndex:(NSInteger)index model:(TaskModel *)taskModel;

- (NSInteger)count;
- (TaskModel *)objectAtInde:(NSUInteger)index;
- (void)dataSourceHasDoneAtIndex:(NSInteger)index;
- (void)deleteAtIndex:(NSInteger)index;

@end
