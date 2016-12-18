//
//  TastListTableViewCell.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/13.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "EditableTableViewCell.h"

@class TaskListTableViewCell;

@protocol TaskListTableViewCellDelegate <NSObject>

@optional

- (void)taskListTableViewCell:(TaskListTableViewCell *)cell cellDidTapDoneAtIndexPath:(NSIndexPath *)indexPath;
- (void)taskListTableViewCell:(TaskListTableViewCell *)cell cellDidTapDeleteAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface TaskListTableViewCell : EditableTableViewCell


- (void)configWithData:(id)data indexPath:(NSIndexPath *)indexPath delegateTarget:(id)delegateTarget;

@end
