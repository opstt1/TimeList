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
    [self addBottomLineWithFrame:CGRectMake(15, self.frame.size.height-3, self.width - 15, 0.5)];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, self.frame.size.height-3-30-3, self.width- 30, 30)];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.delegate = self;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    _textField.text = content;
    
    placeholder = placeholder ?:@"";
    NSMutableAttributedString *mPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [mPlaceholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor grayColor]
                        range:NSMakeRange(0, placeholder.length)];
    [mPlaceholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, placeholder.length)];
    _textField.attributedPlaceholder = mPlaceholder;
    
    [self addSubview:_textField];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ( self.handler ){
        self.handler(textField.text);
    }
}



@end
