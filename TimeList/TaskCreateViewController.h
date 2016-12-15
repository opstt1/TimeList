//
//  TaskCreateViewController.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseViewController.h"
#import "TaskModel.h"

typedef void(^TaskCreateBlock) (TaskModel *model);

@interface TaskCreateViewController : BaseViewController

- (void)createComplete:(TaskCreateBlock)complate;

@end
