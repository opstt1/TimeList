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

+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame content:(NSString *)content actionHandler:(TaskTitleViewHandler)handler
{
    TaskTitleTextView *taskTitleTextView = [self creatWithTitle:title isMust:isMust frame:frame content:content];
    taskTitleTextView.handler = handler;
    return taskTitleTextView;
}


+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame content:(NSString *)content
{
    TaskTitleTextView *taskTitleTextView = [[TaskTitleTextView alloc] initWithFrame:frame];
    [taskTitleTextView creatTextViewWithContent:content placeholder:title];
    return taskTitleTextView;
}

- (void)creatTextViewWithContent:(NSString *)content placeholder:(NSString *)placeholder
{
    [self addBottomLineWithFrame:CGRectMake(15, self.frame.size.height-3, UISCREEN_WIDTH - 15, 0.5)];
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(30, self.frame.size.height-3-30-3, UISCREEN_WIDTH- 60, 30)];
    textFiled.textAlignment = NSTextAlignmentCenter;
    textFiled.delegate = self;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    textFiled.text = content;
    
    textFiled.placeholder = placeholder?:@"";
    
    [self addSubview:textFiled];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ( self.handler ){
        self.handler(textField.text);
    }
}



@end
