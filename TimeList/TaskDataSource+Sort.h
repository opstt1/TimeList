//
//  TaskDataSource+Sort.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/19.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskDataSource.h"

@interface TaskDataSource (Sort)

- (void)sortWithFirstKeyHasDone:(BOOL)hasDone;

- (void)sortWithFirstKeyImptanceFromeHeight:(BOOL) isFromeHeight;

- (void)sortDefault;

@end
