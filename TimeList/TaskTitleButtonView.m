//
//  TaskTitleButtonView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskTitleButtonView.h"
#import "Constants.h"

@interface TaskTitleButtonView()

@property (nonatomic, readwrite, strong) UILabel *showLable;
//@property (nonatomic, readwrite, copy) actionHandler handler;

@end

@implementation TaskTitleButtonView

+(id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame actionHandler:(TaskTitleViewHandler)handler
{
    TaskTitleButtonView *taskTitleButtonView = [self creatWithTitle:title isMust:isMust frame:frame];
    taskTitleButtonView.handler = handler;
    return taskTitleButtonView;
}


+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame
{
    TaskTitleButtonView *taskTitleButtonView = [[TaskTitleButtonView alloc] initWithFrame:frame];
    [taskTitleButtonView creatPublicViewWithTitle:title isMust:isMust];
    [taskTitleButtonView creatButtonView];
    return  taskTitleButtonView;
}

- (void)creatButtonView
{
    CGFloat pointX = 15+kTitleLableWidth+10;
    
    [self addBottomLineWithFrame:CGRectMake(pointX, self.frame.size.height-3, UISCREEN_WIDTH- pointX - 15, 0.5)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(pointX, self.frame.size.height-3-30-3, UISCREEN_WIDTH-pointX-15, 30)];
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _showLable = [[UILabel alloc] initWithFrame:button.frame];
    _showLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_showLable];
    [self addSubview:button];
}

- (void)didTapButton:(id)sender
{
    if ( self.handler ){
        self.handler(nil);
    }
}
- (void)setupLabel:(NSString *)str
{
    
    if ( str ){
        _showLable.text = str;
    }
}
@end
