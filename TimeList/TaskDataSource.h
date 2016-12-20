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

@property (nonatomic, readwrite, copy) NSArray *taskList;
@property (nonatomic, readwrite, weak) id<TaskDataSourceDelegate> delegate;

+ (TaskDataSource *)creatTaksDataWithDate:(NSDate *)date;

- (void)p_dataUpdate;

@end
