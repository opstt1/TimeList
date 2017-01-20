//
//  HourlyRecordDetailView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/20.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordDetailView.h"
#import "Constants.h"
#import "AnalyzeData.h"

#define contentLabelWidth UISCREEN_WIDTH-15-35-10-15
static const CGFloat contentLabelPointX = 15 + 35 + 10 + 10;

@interface HourlyRecordDetailSubView : BaseView

@end

@implementation HourlyRecordDetailSubView


+ (HourlyRecordDetailSubView *)createWithData:(HourlyRecordDataShow *)data
{
    return [[HourlyRecordDetailSubView alloc] initWithData:data];
}

- (instancetype)initWithData:(HourlyRecordDataShow *)data
{
    self = [super initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 10)];
    if ( !self ){
        return self;
    }
    [self initViewWithData:data];
    return self;
}

- (void)initViewWithData:(HourlyRecordDataShow *)data
{
    UILabel *datelabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, UISCREEN_WIDTH, 16.0f)];
    datelabel.font = SYSTEM_FONT_15;
    datelabel.textColor = [UIColor orangeColor];
    datelabel.text = [NSDate stringFromDay:data.startDate formatStr:@"HH:mm"];
    [self addSubview:datelabel];
    
    UILabel *analyzeDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelPointX, 0, 200, 14.0f)];
    analyzeDataLabel.font = [UIFont systemFontOfSize:13.0f];
    analyzeDataLabel.textColor = COLOR_999999;
    analyzeDataLabel.text = [NSString stringWithFormat:@"%@   %.1lf%%",data.timeShow, (float)data.showMinute /  (float)allMinutes * 100];
    [self addSubview:analyzeDataLabel];
    
    CGFloat contentLabelHeight = [data.content sizeWithFont:SYSTEM_FONT_15 width:contentLabelWidth height:CGFLOAT_MAX].height;
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelPointX, 16 + 10.0f, contentLabelWidth, contentLabelHeight)];
    contentLabel.font = SYSTEM_FONT_15;
    contentLabel.textColor = COLOR_333333;
    contentLabel.text = data.content;
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    
    self.height = contentLabel.y + contentLabel.height + 10.0f;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15+15, 17.0, 2, self.height - 17.0-1.0f)];
    line.backgroundColor = data.eventTypeModel.color;
    [self addSubview:line];
    
    
}
@end

@implementation HourlyRecordDetailView

+ (HourlyRecordDetailView *)createWithData:(HourlyRecordDataSource *)data
{
    return [[HourlyRecordDetailView alloc] initWithData:data];
}


- (instancetype)initWithData:(HourlyRecordDataSource *)data
{
    self = [self initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 10)];
    if ( !self ){
        return nil;
    }
    [self initViewWithData:data];
    return self;
}


- (void)initViewWithData:(HourlyRecordDataSource *)data
{
    NSArray *datas = [AnalyzeData hourlyRecordAnalyzeData:data];
    CGFloat pointY = 0;
    
    for ( HourlyRecordDataShow *dataShow in datas ){
        HourlyRecordDetailSubView *view = [HourlyRecordDetailSubView createWithData:dataShow];
        view.frame = CGRectMake(0, pointY, UISCREEN_WIDTH, view.height);
        [self addSubview:view];
        pointY = view.y + view.height;
    }
    
    self.height = pointY;
}

@end
