//
//  TaskTitleView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskTitleView.h"
#import "Constants.h"

@implementation TaskTitleView

+(id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame actionHandler:(TaskTitleViewHandler)handler
{
    return nil;
}

+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame
{
    return nil;
}

- (void)creatPublicViewWithTitle:(NSString *)title isMust:(BOOL)isMust
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (self.frame.size.height-40) / 2, kTitleLableWidth,kTitleLableHeight )];
    titleLabel.minimumScaleFactor = 0.5f;
    
    title = title ?: @"";
    NSString *str = @"";
    if ( isMust ){
        str = [NSString stringWithFormat:@"* %@ :",title];
    }else{
        str = [NSString stringWithFormat:@"  %@ :",title];
    }
    
    titleLabel.text = str;
    titleLabel.textColor = COLOR_666666;
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
   
    
    [self addSubview:titleLabel];

}

- (void)addBottomLineWithFrame:(CGRect)frame
{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.height = 0.5;
    line.backgroundColor = COLOR_BBBBBB;
    
    [self addSubview:line];
}

@end
