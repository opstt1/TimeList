//
//  TaksTitleLongTextView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskTitleLongTextView.h"
#import "Constants.h"

@interface TaskTitleLongTextView()<UITextViewDelegate>

@end

@implementation TaskTitleLongTextView

+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame content:(NSString *)content actionHandler:(TaskTitleViewHandler)handler
{
    TaskTitleLongTextView *view = [[TaskTitleLongTextView alloc] initWithFrame:frame];
    [view creatPublicViewWithTitle:title isMust:isMust];
    [view creatLongTextViewWithFrame:frame content:content];
    view.handler = handler;
    return view;
}

- (void)creatLongTextViewWithFrame:(CGRect)frame content:(NSString *)content
{
    frame.size.height -= kTitleLableHeight;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, kTitleLableHeight, UISCREEN_WIDTH-15*2, frame.size.height)];
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = COLOR_333333.CGColor;
    textView.delegate = self;
    
    if ( content && content.length > 0 ){
        textView.text = content;
    }
    
    textView.font = [UIFont systemFontOfSize:15.0f];
    
    [self addSubview:textView];
    
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ( !textView.text || textView.text.length <= 0 ){
        return;
    }
    
    if ( self.handler ){
        self.handler(textView.text);
    }
}

@end
