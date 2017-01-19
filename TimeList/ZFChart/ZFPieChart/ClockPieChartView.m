//
//  ClockPieChartView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/18.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "ClockPieChartView.h"
#import "ZFChart.h"
#import "Constants.h"
#import "HourlyRecordModel.h"
#import "AnalyzeData.h"


#pragma mark - ClockPieChartView

@interface ClockPieChartView()<ZFPieChartDelegate,ZFPieChartDataSource>

@property (nonatomic, readwrite, strong) ZFPieChart *pieChart;

@property (nonatomic, readwrite, assign) CGFloat pieChartRadius;

@property (nonatomic, readwrite, copy) NSArray *data;

@property (nonatomic, readwrite, strong) UILabel *infoShowLabel;

@property (nonatomic, readwrite, strong) UILabel *timeShowLabel;

@end

@implementation ClockPieChartView


+(ClockPieChartView *)creatWithFrame:(CGRect)frame hourlyRecordData:(HourlyRecordDataSource *)data
{
    ClockPieChartView *view = [[ClockPieChartView alloc] initWithFrame:frame hourlyRecordData:data];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame hourlyRecordData:(HourlyRecordDataSource *)data
{
    self = [self initWithFrame:frame];
    if ( !self ){
        return nil;
    }
    [self calculateData:data];
    [self addPieChart];
    [self addShowInfoView];
    return self;
}

#pragma mark - data

////处理数据，用于统计
- (void)calculateData:(HourlyRecordDataSource *)data
{
    _data = [AnalyzeData hourlyRecordAnalyzeData:data];
}

#pragma mark - add subView
//添加统计图表
- (void)addPieChart
{
    _pieChartRadius = MIN(self.height/4, self.width/4);
    
    _pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(0, 0, _pieChartRadius*2, _pieChartRadius*2)];
    _pieChart.center = CGPointMake(self.width/2, _pieChartRadius);
    _pieChart.delegate = self;
    _pieChart.dataSource = self;
    _pieChart.isShowPercent = NO;
    _pieChart.isShadow = NO;
    
    [_pieChart strokePath];
    [self addSubview:_pieChart];
    [self drawClock];
    _pieChart.center = CGPointMake(self.width/2, self.height / 2); //有待改进
}

//添加时钟指针，24小时制
- (void)drawClock
{
    CGRect frame = CGRectMake(_pieChart.x,_pieChart.y, _pieChart.width+10, _pieChart.height+10);
    CAReplicatorLayer *clockLayer = [CAReplicatorLayer new];
    clockLayer.bounds = frame;
    clockLayer.position = CGPointMake(self.width/2, self.height/2);
    
    [self.layer addSublayer:clockLayer];
    
    CALayer *subLayer = [CALayer layer];
    subLayer.bounds = CGRectMake(0, 0, 2, 5);
    subLayer.position = CGPointMake(_pieChart.centerX+5, 0);
    subLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    
    [clockLayer addSublayer:subLayer];
    clockLayer.instanceCount = 24;
    clockLayer.instanceTransform = CATransform3DMakeRotation((2*M_PI)/24, 0, 0, 1.0);
    
    CGPoint center = clockLayer.position;
    
    //添加时钟显示数字
    for ( int i = 0; i < 4; ++i ){
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(0, 0, 15, 14);
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.foregroundColor = [UIColor blackColor].CGColor;
        textLayer.position = CGPointMake(center.x - (_pieChartRadius + 18), center.y);
        
        UIFont *font = [UIFont systemFontOfSize:14.0f];
        CGFontRef fontRef = CGFontCreateWithFontName((__bridge CFStringRef)font.fontName);
        textLayer.font = fontRef;
        textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        [self.layer addSublayer:textLayer];
        
        textLayer.string = [NSString stringWithFormat:@"%d",i*6];
        
        int y = ( i % 2 == 0 ) ? ( i == 0 ? -1 : 1 ) : 0;
        int x = ( i % 2 == 1 ) ? ( i == 1 ? 1 : -1 ) : 0;
        int gap = _pieChartRadius + 20.0f;
        textLayer.position = CGPointMake(center.x + gap * x, center.y + gap * y);
    }
}

//添加一些信息展示的view，例如标题，选中的任务详情，使用时间
- (void)addShowInfoView
{
    _infoShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.width, 15)];
    _infoShowLabel.textAlignment = NSTextAlignmentCenter;
    _infoShowLabel.font = [UIFont systemFontOfSize:15.0f];
    _infoShowLabel.textColor = COLOR_666666;
    [self addSubview:_infoShowLabel];
    
    _timeShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _pieChartRadius/ 2 + 20, 14)];
    _timeShowLabel.center = _pieChart.center;
    _timeShowLabel.textAlignment = NSTextAlignmentCenter;
    _timeShowLabel.font = [UIFont systemFontOfSize:12.0f];
    _timeShowLabel.textColor = COLOR_666666;
    [self addSubview:_timeShowLabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 15, self.width, 15)];
    label.text = @"时间记录分布";
    label.font = [UIFont boldSystemFontOfSize:16.0f];
    label.textColor = COLOR_333333;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

#pragma mark - ZFPieChartDataSource

- (NSArray *)valueArrayInPieChart:(ZFPieChart *)chart
{
    NSMutableArray *value = [NSMutableArray array];
    for ( HourlyRecordDataShow *show in _data ){
        [value addObject:show.minuteStr];
    }
    
    return [NSArray arrayWithArray:value];
}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart
{
    NSMutableArray *value = [NSMutableArray array];
    for ( HourlyRecordDataShow *show in _data ){
        [value addObject:show.eventTypeModel.color];

    }
    return [NSArray arrayWithArray:value];
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index
{
    HourlyRecordDataShow *show = _data[index];
    _infoShowLabel.text = [NSString stringWithFormat:@"%@ -- (%@)%@ -- %@",show.startTime, show.eventTypeModel.title,show.content,show.endTime];
    _infoShowLabel.textColor = show.eventTypeModel.color;
    
    if ( show.showMinute / 60 > 0 ){
        if ( show.showMinute % 60 != 0 ){
            _timeShowLabel.text = [NSString stringWithFormat:@"%d 时 %d 分",(int)show.showMinute/60,(int)show.showMinute % 60];
        }else{
            _timeShowLabel.text = [NSString stringWithFormat:@"%d 时",(int)show.showMinute/60];
        }
    }else{
         _timeShowLabel.text = [NSString stringWithFormat:@"%d 分",(int)show.showMinute];
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
