//
//  TaskDataSource+Sort.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/19.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskDataSource+Sort.h"
#import "TaskDataSource+Func.h"
#import "TaskModel.h"

#define statusSortDescriptor(x) [NSSortDescriptor sortDescriptorWithKey:TaskModelStatusKey ascending:x]

#define importanceSortDescriptor(x) [NSSortDescriptor sortDescriptorWithKey:TaskModelImportanceKey ascending:x]
#define localIdSortDescriptor(x) [NSSortDescriptor sortDescriptorWithKey:TaskModelLocalIdKey ascending:x]


@implementation TaskDataSource (Sort)


- (void)sortWithFirstKeyHasDone:(BOOL)hasDone
{
    if ( !self || !self.taskList || self.taskList.count <= 0 ){
        return;
    }
    
    NSArray *array = [NSArray arrayWithArray:self.taskList];
    NSArray *descriptorArray = [NSArray arrayWithObjects:statusSortDescriptor(!hasDone),importanceSortDescriptor(NO),localIdSortDescriptor(YES), nil];
    NSArray *sortArray = [array sortedArrayUsingDescriptors:descriptorArray];
    
    [self dataSourceWithArray:sortArray];
    
}

- (void)sortWithFirstKeyImptanceFromeHeight:(BOOL)isFromeHeight
{
    
    NSArray *array = [NSArray arrayWithArray:self.taskList];
    NSArray *descriptorArray = [NSArray arrayWithObjects:importanceSortDescriptor(!isFromeHeight),statusSortDescriptor(YES),localIdSortDescriptor(YES), nil];
    NSArray *sortArray = [array sortedArrayUsingDescriptors:descriptorArray];
    
    [self dataSourceWithArray:sortArray];
}


- (NSSortDescriptor *)sortDescriptorWithKey:(NSString *)key ascending:(BOOL)ascending
{
    return [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
}


- (void)sortDefault
{
    if ( !self || !self.taskList || self.taskList.count <= 0 ){
        return;
    }
    NSArray *array = [NSArray arrayWithArray:self.taskList];
    NSArray *descriptorArray = [NSArray arrayWithObjects:statusSortDescriptor(YES),localIdSortDescriptor(YES),importanceSortDescriptor(NO), nil];
    NSArray *sortArray = [array sortedArrayUsingDescriptors:descriptorArray];
    [self dataSourceWithArray:sortArray];

}


@end
