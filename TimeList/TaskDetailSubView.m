//
//  TaskDetailSubView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/21.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskDetailSubView.h"
#import "TaskTitleTextView.h"
#import "TaskTitleButtonView.h"
#import "TaskTitleTwoSelectView.h"
#import "TaskTitleButtonView.h"
#import "TaskTitleTwoSelectView.h"
#import "TaskTitleLongTextView.h"

@implementation TaskDetailSubView

+ (TaskTitleTextView *)creatTaskTitleViewWithFrame:(CGRect)frame type:(TaskDetailType)type content:(NSString *)content actionHandler:(TaskTitleViewHandler)actionHandler
{
    TaskTitleTextView *view = [TaskTitleTextView creatWithTitle:@"任务名称"
                                                          isMust:YES
                                                           frame:frame
                                                        content:content
                                                   actionHandler:actionHandler];
    if ( type == TaskDetail_Show || type == TaskDetail_Summary ){
        view.canEdit = NO;
    }
    return view;

}

+ (TaskTitleButtonView *)creatImportanceViewWithFrame:(CGRect)frame type:(TaskDetailType)type content:(NSString *)content actionHandler:(TaskTitleViewHandler)actionHandler
{
    TaskTitleButtonView *view = [TaskTitleButtonView creatWithTitle:@"任务重要度"
                                                         isMust:YES
                                                          frame:frame
                                                        content:content
                                                  actionHandler:actionHandler];
    if ( type == TaskDetail_Show || type == TaskDetail_Summary ){
        view.canEdit = NO;
    }
    return view;
    
}


+ (TaskTitleTwoSelectView *)creatIsCompleteTaskViewWithFrame:(CGRect)frame type:(TaskDetailType)type hasDone:(BOOL)hasDone actionHandler:(TaskTitleViewHandler)actionHandler
{
    TaskTitleTwoSelectView *view = [TaskTitleTwoSelectView creatWithTitle:@"是否完成"
                                                         isMust:YES
                                                          frame:frame
                                                        content:(hasDone?@"done" : @"unDone")
                                                  actionHandler:actionHandler];
    if ( type == TaskDetail_Show || type == TaskDetail_Summary ){
        view.canEdit = NO;
    }
    return view;
    
}

+ (TaskTitleLongTextView *)creatTaskSummaryViewWithFrame:(CGRect)frame type:(TaskDetailType)type content:(NSString *)content actionHandler:(TaskTitleViewHandler)actionHandler
{
    TaskTitleLongTextView *view = [TaskTitleLongTextView creatWithTitle:@"总结" isMust:NO frame:frame content:content actionHandler:actionHandler];
    if ( type == TaskDetail_Creat || type == TaskDetail_Show ){
        view.canEdit = NO;
    }
    return view;
}

@end
