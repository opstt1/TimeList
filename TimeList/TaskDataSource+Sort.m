//
//  TaskDataSource+Sort.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/19.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskDataSource+Sort.h"
#import "TaskModel.h"

@implementation TaskDataSource (Sort)


- (void)sortWithFirstKeyHasDone:(BOOL)hasDone
{
    if ( !self || !self.taskList || self.taskList.count <= 0 ){
        return;
    }
    NSArray *array = [NSArray arrayWithArray:self.taskList];
    NSSortDescriptor *statusDesc = [NSSortDescriptor sortDescriptorWithKey:TaskModelStatusKey ascending:!hasDone];
    NSSortDescriptor *importanceDesc = [NSSortDescriptor sortDescriptorWithKey:TaskModelImportanceKey ascending:NO];
    NSSortDescriptor *localIdDesc = [NSSortDescriptor sortDescriptorWithKey:TaskModelLocalIdKey ascending:YES];
    
    NSArray *descriptorArray = [NSArray arrayWithObjects:statusDesc,importanceDesc,localIdDesc, nil];
    NSArray *sortArray = [array sortedArrayUsingDescriptors:descriptorArray];
    [self dataSourceWithArray:sortArray];
    
}

- (void)sortWithFirstKeyImptanceFromeHeight:(BOOL)isFromeHeight
{
    
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
    NSSortDescriptor *statusDesc = [NSSortDescriptor sortDescriptorWithKey:TaskModelStatusKey ascending:YES];
    NSSortDescriptor *importanceDesc = [NSSortDescriptor sortDescriptorWithKey:TaskModelImportanceKey ascending:NO];
    NSSortDescriptor *localIdDesc = [NSSortDescriptor sortDescriptorWithKey:TaskModelLocalIdKey ascending:YES];
    
    NSArray *descriptorArray = [NSArray arrayWithObjects:statusDesc,localIdDesc,importanceDesc, nil];
    NSArray *sortArray = [array sortedArrayUsingDescriptors:descriptorArray];
    [self dataSourceWithArray:sortArray];

}


@end
