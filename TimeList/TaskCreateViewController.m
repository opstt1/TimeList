//
//  TaskCreateViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskCreateViewController.h"
#import "TaskTitleTextView.h"
#import "TaskTitleButtonView.h"
#import "PickerSheetView.h"
#import "TaskTitleTwoSelectView.h"

#import "Constants.h"

@interface TaskCreateViewController ()

@property (nonatomic, readwrite, copy) TaskCreateBlock complete;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@property (nonatomic, readwrite, strong) TaskTitleButtonView *importanceView;
@property (nonatomic, readwrite, strong) TaskModel *model;


@end

@implementation TaskCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentViewHeight.constant = UISCREEN_HEIGHT-65;
    [self setUpRightNavigationButtonWithTitle:@"Save" tintColor:nil];
    _model = [[TaskModel alloc] init];
    [self p_addSubView];
    
}

- (void)p_addSubView
{
    WEAK_OBJ_REF(self);
    TaskTitleTextView *view1 = [TaskTitleTextView creatWithTitle:@"任务名称"
                                                          isMust:YES
                                                           frame:CGRectMake(0,20,UISCREEN_WIDTH,40)
                                                   actionHandler:^(id result) {
                                                       NSLog(@"lalalla:   %@",result);
                                                       STRONG_OBJ_REF(weak_self);
                                                       if( strong_weak_self && result ){
                                                           _model.title = result;
                                                       }
                                                       
                                                   }];
    
    

    _importanceView = [TaskTitleButtonView creatWithTitle:@"任务重要度"
                                                   isMust:YES
                                                    frame:CGRectMake(0, 40+10+20, UISCREEN_WIDTH, 40)
                                            actionHandler:^(id result){
                                                
                                                [PickerSheetView createWithTitles:IMPORTANCE_ARRAY
                                                                        superView:self.view
                                                                    actionHandler:^(id result) {
                                                                        NSInteger importance = [result integerValue];
                                                                        STRONG_OBJ_REF(weak_self);
                                                                        if ( strong_weak_self ){
                                                                            [_importanceView setupLabel:[NSString stringWithFormat:@"%d",(int)importance]];
                                                                            _model.importance = importance;
                                                                        }
                                                                        
                                                                    }];
                                            }];
    
    
    TaskTitleTwoSelectView *view2 = [TaskTitleTwoSelectView creatWithTitle:@"是否完成" isMust:YES frame:CGRectMake(0, (40+10) * 2 +20, UISCREEN_WIDTH, 40) actionHandler:^(id result) {
        NSLog(@"selecgt:   %@",result);
        STRONG_OBJ_REF(weak_self);
        if( strong_weak_self && result ){
            if ( [result isEqualToString:@"done"] ){
                _model.status = TaskHasBeenDone;
            }else{
                _model.status = TaskUndone;
            }
        }
        
    }];
    [_contentView addSubview:view1];
    [_contentView addSubview:_importanceView];
    [_contentView addSubview:view2];
}

- (void)createComplete:(TaskCreateBlock)complate
{
    _complete = complate;
    if ( !_model ){
        _model = [[TaskModel alloc] init];
    }
}

#pragma mark - action

- (void)rightNavigationButtonTapped:(id)sender
{
    NSLog(@"%@",_model);
}
@end
