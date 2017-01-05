//
//  HourlyRecordView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/5.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordView.h"
#import "Constants.h"

#define contentLabelWidth UISCREEN_WIDTH-15-35-10-15
static const CGFloat contentLabelPointX = 15+35+10;

@interface HourlyRecordView()

@property (nonatomic, readwrite, assign) CGFloat viewHeight;

@end

@implementation HourlyRecordView

+ (HourlyRecordView *)createWithDate:(NSDate *)date content:(NSString *)content
{
    return [[HourlyRecordView alloc] initWithDate:date content:content];
}


- (instancetype)initWithDate:(NSDate *)date content:(NSString *)content
{
    self = [self init];
    if ( !self ){
        return nil;
    }
    [self initViewWithDate:date content:content];
    return self;
}


- (void)initViewWithDate:(NSDate *)date content:(NSString *)content
{
    UILabel *datelabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, UISCREEN_WIDTH, 16.0f)];
    datelabel.font = SYSTEM_FONT_15;
    datelabel.textColor = [UIColor orangeColor];
    datelabel.text = [NSDate stringFromDay:date formatStr:@"HH:mm"];
    
    [self addSubview:datelabel];
    
    CGFloat contentLabelHeight = [content sizeWithFont:SYSTEM_FONT_15 width:contentLabelWidth height:CGFLOAT_MAX].height;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelPointX, 16+2, contentLabelWidth, contentLabelHeight)];
    contentLabel.font = SYSTEM_FONT_15;
    contentLabel.textColor = COLOR_666666;
    contentLabel.text = content;
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    
  
    
    _viewHeight = contentLabel.y + contentLabel.height + 2.0f;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15+15, 17.0, 1, _viewHeight - 17.0-1.0f)];
    line.backgroundColor = [UIColor orangeColor];
    [self addSubview:line];
    
    
}
@end
