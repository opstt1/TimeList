//
//  SheetMaskView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "SheetMaskView.h"
#import "Constants.h"

@implementation SheetMaskView

- (instancetype)init
{
    
    self = [super initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    if( !self ) return nil;
    
    UIButton *button = [[UIButton alloc] initWithFrame:self.frame];
    button.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return self;
}


- (void)showWithSuperView:(UIView *)superView
{
    [superView addSubview:self];
    self.y = UISCREEN_HEIGHT;
    [UIView animateWithDuration:0.3 animations:^{
        self.y = 0;
    }];
}

- (void)dismiss
{
    if ( !self.superview){
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.y = UISCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
