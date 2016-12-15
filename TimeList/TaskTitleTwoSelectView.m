//
//  TaskTitleTwoSelectView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskTitleTwoSelectView.h"

@interface TaskTitleTwoSelectView()

@property (nonatomic, readwrite, strong) UIButton *doneButton;
@property (nonatomic, readwrite, strong) UIButton *unDoneButton;


@end

@implementation TaskTitleTwoSelectView

+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame actionHandler:(TaskTitleViewHandler)handler
{
    TaskTitleTwoSelectView *taskTitleTwoSelectView = [[TaskTitleTwoSelectView alloc] initWithFrame:frame];
    [taskTitleTwoSelectView creatPublicViewWithTitle:title isMust:isMust];
    taskTitleTwoSelectView.handler = handler;
    [taskTitleTwoSelectView createSelectButton];
    return taskTitleTwoSelectView;
}


- (void)createSelectButton
{
    CGFloat pointX = 15+kTitleLableWidth+10;
    _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(pointX, (self.frame.size.height-34)/2, 80, 34)];
    _doneButton.layer.cornerRadius = 5.0f;
    [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _doneButton.tag = 0;
    _doneButton.backgroundColor = [UIColor grayColor];
    [_doneButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _unDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(pointX + _doneButton.frame.size.width + 15, (self.frame.size.height-34)/2, 80, 34)];
    _unDoneButton.layer.cornerRadius = 5.0f;
    [_unDoneButton setTitle:@"UnDone" forState:UIControlStateNormal];
    [_unDoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _unDoneButton.tag = 1;
    _unDoneButton.backgroundColor = [UIColor redColor];
    [_unDoneButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_doneButton];
    [self addSubview:_unDoneButton];
}

#pragma mark - action

- (void)didTapButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    if ( tag == 0 ){
        _doneButton.backgroundColor = [UIColor greenColor];
        _unDoneButton.backgroundColor = [UIColor grayColor];
    }
    
    if ( tag == 1 ){
        _doneButton.backgroundColor = [UIColor grayColor];
        _unDoneButton.backgroundColor = [UIColor redColor];
    }
    
    if ( self.handler ){
        self.handler((tag == 0 ) ? @"done" : @"undone");
    }
}
@end
