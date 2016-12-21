//
//  TaskDetailSubView.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/21.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskTitleView.h"

@class TaskTitleTextView;
@class TaskTitleButtonView;
@class TaskTitleTwoSelectView;

typedef NS_ENUM(NSInteger, TaskDetailType){
    TaskDetail_Creat,     //创建
    TaskDetail_Show,      //展示
    TaskDetail_Update,    //更新
    TaskDetail_Summary    //总结
};

@interface TaskDetailSubView : NSObject


+ (TaskTitleTextView *)creatTaskTitleViewWithFrame:(CGRect)frame type:(TaskDetailType)type content:(NSString *)content actionHandler:(TaskTitleViewHandler)actionHandler;

+ (TaskTitleButtonView *)creatImportanceViewWithFrame:(CGRect)frame type:(TaskDetailType)type content:(NSString *)content actionHandler:(TaskTitleViewHandler)actionHandler;

+ (TaskTitleTwoSelectView *)creatIsCompleteTaskViewWithFrame:(CGRect)frame type:(TaskDetailType)type hasDone:(BOOL)hasDone actionHandler:(TaskTitleViewHandler)actionHandler;

@end
