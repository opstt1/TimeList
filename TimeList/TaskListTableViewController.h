//
//  TastListTableViewController.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseViewController.h"

@class TaskDataSource;
@class DailySummaryDataSource;

@interface TaskListTableViewController : BaseViewController

- (void)configWithData:(TaskDataSource *)dataSource dailySummaryDataSource:(DailySummaryDataSource *)dailySummaryDataSource;
- (void)configWithData:(TaskDataSource *)dataSource;

@end
