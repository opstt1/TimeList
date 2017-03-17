//
//  TaskCreateViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskDetailViewController.h"
#import "TaskTitleTextView.h"
#import "TaskTitleButtonView.h"
#import "PickerSheetView.h"
#import "TaskTitleTwoSelectView.h"
#import "UIView+Toast.h"
#import "Constants.h"
#import "TaskModel+FMDB.h"
#import "TaskTitleLongTextView.h"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "UIViewController+BackButtonHandler.h"
#import "RectAnimationTransitionPop.h"
#import "EventTypeManager.h"
#import "EventTypeListViewController.h"
#import "TaskImportaceView.h"
@interface TaskDetailViewController ()<UINavigationControllerDelegate>

@property (nonatomic, readwrite, copy) TaskDetailBlock detailBlock;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@property (nonatomic, readwrite, strong) TaskImportaceView *importanceView;
@property (nonatomic, readwrite, strong) TaskModel *model;


@end

@implementation TaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentViewHeight.constant = UISCREEN_HEIGHT-65;
    [self setUpRightNavigationButtonWithTitle:@"Save" tintColor:nil];
    if ( !_model ){
        _model = [[TaskModel alloc] init];
        _model.status = TaskUndone;
    }
    [self p_addSubView];
    [self addBlockTaskView];
}


- (void)p_addSubView
{
    WEAK_OBJ_REF(self);
    
    //填写任务名称
    TaskTitleTextView *view1 = [TaskDetailSubView creatTaskTitleViewWithFrame:CGRectMake(0, 40+10+20, UISCREEN_WIDTH, 40)
                                                                         type:_type
                                                                      content:_model.title
                                                                actionHandler:^(id result) {
        NSLog(@"lalalla:   %@",result);
        STRONG_OBJ_REF(weak_self);
        if( strong_weak_self && result ){
            _model.title = result;
        }
    }];
    
    //填写任务重要度
    _importanceView = [TaskDetailSubView creatImportanceViewWithFrame:CGRectMake(0,20,UISCREEN_WIDTH,40)
                                                                 type:_type
                                                              content:(_model.importance < 0) ? @"" :[NSString stringWithFormat:@"%d",(int)_model.importance]
                                                        actionHandler:^(id result) {
        [PickerSheetView createWithTitles:IMPORTANCE_ARRAY
                                superView:self.view
                            actionHandler:^(id result) {
                                NSInteger importance = [result integerValue];
                                STRONG_OBJ_REF(weak_self);
                                if ( strong_weak_self ){
                                    [_importanceView setupImportance:[NSString stringWithFormat:@"%d",(int)importance]];
                                    _model.importance = importance;
                                }
                                
                            }];

    }];
    

    TaskTitleLongTextView *summaryView = [TaskDetailSubView creatTaskSummaryViewWithFrame:CGRectMake(0, (40+10) * 3 + 20, UISCREEN_WIDTH, 150) type:_type content:_model.summarize actionHandler:^(id result) {
        NSLog(@"");
        STRONG_OBJ_REF(weak_self);
        if ( strong_weak_self && result ){
            _model.summarize = result;
        }
    }];
    
    [_contentView addSubview:view1];
    [_contentView addSubview:_importanceView];
//    [_contentView addSubview:summaryView];
}


- (void)addBlockTaskView
{
    TaskTitleTextView *daysCountView = [TaskDetailSubView createBlockTaskDaysViewWithFrame:CGRectMake(0, _importanceView.y+100, 30+60+30, 40.0f) type:_type content:@"" actionHandler:^(id result) {
        printf("days  %d",((NSString *)result).integerValue);
    }];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(daysCountView.right, daysCountView.y, 20, 40.0f)];
    label.text = @"天";
    [_contentView addSubview:label];
    [_contentView addSubview:daysCountView];
    
    UILabel *needSturdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.right + 5, label.y, 80, 12)];
    needSturdayLabel.font = [UIFont systemFontOfSize:13.0f];
    needSturdayLabel.text = @"是否周六进行";
    needSturdayLabel.backgroundColor = [UIColor redColor];
    [_contentView addSubview:needSturdayLabel];
    
    UISwitch *needSturdaySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(needSturdayLabel.x, needSturdayLabel.y+ 15.0f, needSturdayLabel.width, 25.0f)];
    [_contentView addSubview:needSturdaySwitch];
    
    UILabel *needWeekDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(needSturdayLabel.right + 5, needSturdayLabel.y, 80, 12)];
    needWeekDayLabel.font = [UIFont systemFontOfSize:13.0f];
    needWeekDayLabel.text = @"是否周日进行";
    [_contentView addSubview:needWeekDayLabel];
    
    UISwitch *needWeekDaySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(needWeekDayLabel.x, needWeekDayLabel.y+15.0f, needWeekDayLabel.width, 25.0f)];
    [_contentView addSubview:needWeekDaySwitch];
}

#pragma mark - interface select type

- (void)createComplete:(TaskDetailBlock)complete
{
    _type = TaskDetail_Creat;
    [self p_setModel:nil complete:complete];
}

- (void)summaryTask:(TaskModel *)task complete:(TaskDetailBlock)complete
{
    _type = TaskDetail_Summary;
    [self p_setModel:task complete:complete];
}

- (void)updateTask:(TaskModel *)task complete:(TaskDetailBlock)complete
{
    _type = TaskDetail_Update;
    [self p_setModel:task complete:complete];
}


- (void)showTask:(TaskModel *)task
{
    _type = TaskDetail_Show;
    [self p_setModel:task complete:nil];
}

- (void)p_setModel:(TaskModel *)taskModel complete:(TaskDetailBlock)complate
{
    if ( !taskModel ){
        taskModel = [[TaskModel alloc] init];
        taskModel = TaskUndone;
    }
    _model = taskModel;
    _detailBlock = complate;
}

#pragma mark - action

//保存
- (void)rightNavigationButtonTapped:(id)sender
{
    if ( ![_model dataIntegrity] ) {
        [self.view makeToast:@"请填写全信息" duration:1.5f position:[NSValue valueWithCGPoint:self.view.center] ];
        return;
    }
    if ( _detailBlock ){
        _detailBlock(_model);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });

}

//- (BOOL)navigationShouldPopOnBackButton
//{
//    self.navigationController.delegate = self;
//    return YES;
//}
@end
