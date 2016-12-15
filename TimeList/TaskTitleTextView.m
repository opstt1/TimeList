//
//  TaskTitleTextView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskTitleTextView.h"
#import "Constants.h"
#import "IQKeyboardManager.h"

@interface TaskTitleTextView()<UITextFieldDelegate>

@end

@implementation TaskTitleTextView

+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame actionHandler:(TaskTitleViewHandler)handler
{
    TaskTitleTextView *taskTitleTextView = [self creatWithTitle:title isMust:isMust frame:frame];
    taskTitleTextView.handler = handler;
    return taskTitleTextView;
}


+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame
{
    TaskTitleTextView *taskTitleTextView = [[TaskTitleTextView alloc] initWithFrame:frame];
    [taskTitleTextView creatPublicViewWithTitle:title isMust:isMust];
    [taskTitleTextView creatTextView];
    return taskTitleTextView;
}

- (void)creatTextView
{
    CGFloat pointX = 15+kTitleLableWidth+10;
    
    [self addBottomLineWithFrame:CGRectMake(pointX, self.frame.size.height-3, UISCREEN_WIDTH- pointX - 15, 0.5)];
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(pointX, self.frame.size.height-3-30-3, UISCREEN_WIDTH-pointX-15, 30)];
    textFiled.textAlignment = NSTextAlignmentCenter;
    textFiled.delegate = self;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [self addSubview:textFiled];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{

    if ( self.handler ){
        self.handler(textField.text);
    }
}
@end
