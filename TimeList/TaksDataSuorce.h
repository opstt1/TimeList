//
//  TaksDataSuorce.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskModel;

@interface TaksDataSuorce : NSObject

+ (TaksDataSuorce *)creatTaksDataWithDate:(NSDate *)date;

- (void)addTaskModel:(TaskModel *)taskModel;
- (NSInteger)count;
- (TaskModel *)objectAtInde:(NSUInteger)index;

@end
