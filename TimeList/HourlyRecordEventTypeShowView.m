//
//  HourlyRecordEventTypeShowView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/19.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordEventTypeShowView.h"
#import "AnalyzeData.h"
#import "Constants.h"
#import "ZFChart.h"

@interface HourlyRecordEventTypeShowView()<ZFPieChartDelegate,ZFPieChartDataSource>

@property (nonatomic, readwrite, copy) NSArray *data;


@property (nonatomic, readwrite, strong) ZFPieChart *pieChart;

@property (nonatomic, readwrite, assign) CGFloat pieChartRadius;

@property (nonatomic, readwrite, strong) UILabel *showLabel;

@end

@implementation HourlyRecordEventTypeShowView

+ (HourlyRecordEventTypeShowView *)creatWithFrame:(CGRect)frame hourlyRecordData:(HourlyRecordDataSource *)data
{
    HourlyRecordEventTypeShowView *showView = [[HourlyRecordEventTypeShowView alloc] initWithFrame:frame data:data];
    
    return showView;
}

- (instancetype)initWithFrame:(CGRect)frame data:(HourlyRecordDataSource *)data
{
    self = [self initWithFrame:frame];
    if ( !self ){
        return nil;
    }
    [self analyzeData:data];
    [self addPieChart];
    [self addDataShowLabel];
    return self;
}

- (void)analyzeData:(HourlyRecordDataSource *)data
{
    _data = [AnalyzeData hourlyRecordTypeAnalyzeData:data];
}

- (void)addPieChart
{
    _pieChartRadius = MIN(self.height/4, self.width/4);
    
    _pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(0, 0, _pieChartRadius*2, _pieChartRadius*2)];
    _pieChart.center = CGPointMake(self.width/2, self.height/2);
    _pieChart.delegate = self;
    _pieChart.dataSource = self;
    _pieChart.isShowPercent = YES;
    _pieChart.isShadow = YES;
    _pieChart.piePatternType = kPieChartPatternTypeForCircle;
    [_pieChart strokePath];
    [self addSubview:_pieChart];
}


- (void)addDataShowLabel
{
    _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.width/2 - _pieChartRadius - 20 - 50, self.width, 50)];
    _showLabel.textAlignment = NSTextAlignmentCenter;
    _showLabel.numberOfLines = 2;
    _showLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _showLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [self addSubview:_showLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height/2+ _pieChartRadius + 40, self.width, 16)];
    titleLabel.text = @"时间记录类型分布";
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = COLOR_333333;
    [self addSubview:titleLabel];
}

#pragma mark - ZFPieChartDataSource

- (NSArray *)valueArrayInPieChart:(ZFPieChart *)chart
{
    NSMutableArray *value = [NSMutableArray array];
    for ( HourlyRecordEventTypeShow *show in _data ){
        [value addObject:show.minuteStr];
    }
    
    return [NSArray arrayWithArray:value];
}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart
{
    NSMutableArray *value = [NSMutableArray array];
    for ( HourlyRecordEventTypeShow *show in _data ){
        [value addObject:show.color];
        
    }
    return [NSArray arrayWithArray:value];
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index
{
    NSLog(@"popopopop");
    HourlyRecordEventTypeShow *show = _data[index];
    _showLabel.text = [NSString stringWithFormat:@"%@\n%@",show.title,show.minuteStr];
    _showLabel.textColor = show.color;
    
    if ( show.showMinute / 60 > 0 ){
        if ( show.showMinute % 60 != 0 ){
            _showLabel.text = [NSString stringWithFormat:@"%@\n%d 小时 %d 分钟",show.title,(int)show.showMinute/60,(int)show.showMinute % 60];
        }else{
            _showLabel.text = [NSString stringWithFormat:@"%@\n%d 小时",show.title,(int)show.showMinute/60];
        }
    }else{
        _showLabel.text = [NSString stringWithFormat:@"%@\n%d 分种",show.title,(int)show.showMinute];
    }
}

- (CGFloat)allowToShowMinLimitPercent:(ZFPieChart *)pieChart{
    return 5.f;
}

- (CGFloat)radiusForPieChart:(ZFPieChart *)pieChart{
    return _pieChartRadius;
}

/** 此方法只对圆环类型(kPieChartPatternTypeForCirque)有效 */
- (CGFloat)radiusAverageNumberOfSegments:(ZFPieChart *)pieChart{
    return 2.f;
}
@end
