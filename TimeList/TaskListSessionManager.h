//
//  TaskListSessionManager.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskDataSource;

@interface TaskListSessionManager : NSObject

+ (instancetype)sharedManager;

- (TaskDataSource *)dataSource;

@end
