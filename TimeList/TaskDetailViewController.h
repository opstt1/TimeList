//
//  TaskCreateViewController.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseViewController.h"
#import "TaskModel.h"
#import "TaskDetailSubView.h"
//typedef NS_ENUM(NSInteger, TaskDetailType){
//    TaskDetail_Creat,     //创建
//    TaskDetail_Show,      //展示
//    TaskDetail_Update,    //更新
//    TaskDetail_Summary    //总结
//};

typedef void(^TaskDetailBlock) (TaskModel *model);

@interface TaskDetailViewController : BaseViewController

@property (nonatomic, readwrite, assign) TaskDetailType type;


- (void)createComplete:(TaskDetailBlock)complete;

- (void)summaryTask:(TaskModel *)task complete:(TaskDetailBlock)complete;
- (void)updateTask:(TaskModel *)task complete:(TaskDetailBlock)complete;
- (void)showTask:(TaskModel *)task;

@end
