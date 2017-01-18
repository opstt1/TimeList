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

static NSInteger allMinutes = 24 * 60;

@interface HourlyRecordDataShow :HourlyRecordModel

@property (nonatomic, readwrite, assign) NSInteger showMinute;
@property (nonatomic, readwrite, strong) NSString *minuteStr;

+ (HourlyRecordDataShow *)createUnknownShowWitMinute:(NSInteger)minute startDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (HourlyRecordDataShow *)createShowWithMinute:(NSInteger)minute model:(HourlyRecordModel *)model;

@end

@implementation HourlyRecordDataShow

+ (HourlyRecordDataShow *)createUnknownShowWitMinute:(NSInteger)minute startDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    HourlyRecordDataShow *show = [[HourlyRecordDataShow alloc] init];
    [show createUnknownShowWitMinute:minute startDate:startDate endDate:endDate];
    return show;
}

+ (HourlyRecordDataShow *)createShowWithMinute:(NSInteger)minute model:(HourlyRecordModel *)model
{
    HourlyRecordDataShow *show = [[HourlyRecordDataShow alloc] init];
    [show createShowWithMinute:minute model:model];
    return show;
}

- (void)createUnknownShowWitMinute:(NSInteger)minute startDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    self.showMinute = minute;
    self.content = @"未知";
    self.startDate = startDate;
    self.endDate = endDate;
    self.eventTypeModel.title = @"未知";
    self.eventTypeModel.identifier = [[UIColor grayColor] hexString];
    self.minuteStr = [NSString stringWithFormat:@"%d",(int)minute];
}


- (void)createShowWithMinute:(NSInteger)minute model:(HourlyRecordModel *)model
{
    self.showMinute = minute;
    self.content = model.content;
    self.startDate = model.startDate;
    self.endDate = model.endDate;
    self.eventTypeModel = model.eventTypeModel;
    if ( [self.eventTypeModel.identifier isEqualToString:@""] ){
        self.eventTypeModel.title = @"未知";
        self.eventTypeModel.identifier = [[UIColor grayColor] hexString];
    }
    
    self.minuteStr = [NSString stringWithFormat:@"%d",(int)minute];
}

@end

@interface ClockPieChartView()<ZFPieChartDelegate,ZFPieChartDataSource>

@property (nonatomic, readwrite, strong) ZFPieChart *pieChart;

@property (nonatomic, readwrite, assign) CGFloat pieChartRadius;

@property (nonatomic, readwrite, copy) NSArray *data;


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
    return self;
}


- (void)calculateData:(HourlyRecordDataSource *)data
{
    NSMutableArray *timeArray = [NSMutableArray array];
    if ( !data || data.count <= 0 ){
        return;
    }
    
    NSInteger residueMinutes = allMinutes;
    
    HourlyRecordModel *first = [data objectAtInde:data.count-1];
    NSLog(@"secont: ----%@ %d",first.startTime,(int)[first.startDate timeIntervalSinceDate:[first.startDate beginningOfDay]]/60);
    NSInteger minute = [first.startDate minutesIntervalSinceDate:[first.startDate beginningOfDay]];
    if( minute > 0 ){
        HourlyRecordDataShow *show = [[HourlyRecordDataShow alloc] init];
        [show createUnknownShowWitMinute:minute startDate:[first.startDate beginningOfDay] endDate:first.startDate];
        [timeArray addObject:show];
        
        residueMinutes -= minute;
    }
    
    for ( int i = (int)data.count - 1; i >= 0; --i ){
        HourlyRecordModel *model = [data objectAtInde:i];
        NSInteger minute = 0;
        
        if ( i != data.count - 1 ){
            HourlyRecordModel *preModel = [data objectAtInde:i+1];
            if ( ![preModel.endDate isSameMinute:model.startDate] ){
                minute = [preModel.endDate timeIntervalSinceDate:model.startDate] / 60;
                HourlyRecordDataShow *show = [HourlyRecordDataShow createUnknownShowWitMinute:minute startDate:preModel.endDate endDate:model.startDate];
                [timeArray addObject:show];
                residueMinutes -= minute;
            }
        }
        
        minute = [model.startDate minutesIntervalSinceDate:model.endDate];
        HourlyRecordDataShow *show = [HourlyRecordDataShow createShowWithMinute:minute model:model];
        [timeArray addObject:show];
        residueMinutes -= minute;
    }

    if ( residueMinutes > 0 ){
        HourlyRecordModel *preModel = [data objectAtInde:0];
        minute = [preModel.endDate minutesIntervalSinceDate:[preModel.endDate endOfDay]];
        HourlyRecordDataShow *show = [HourlyRecordDataShow createUnknownShowWitMinute:minute startDate:preModel.endDate endDate:[preModel.endDate endOfDay]];
        [timeArray addObject:show];
    }
    
    _data = [NSArray arrayWithArray:timeArray];
}

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
    _pieChart.center = CGPointMake(self.width/2, _pieChartRadius + 50);
}


- (void)drawClock
{
    CGRect frame = CGRectMake(_pieChart.x,_pieChart.y, _pieChart.width+10, _pieChart.height+10);
    CAReplicatorLayer *clockLayer = [CAReplicatorLayer new];
    clockLayer.bounds = frame;
    clockLayer.position = CGPointMake(self.width/2, _pieChartRadius+50);
    
    [self.layer addSublayer:clockLayer];
    
    CALayer *subLayer = [CALayer layer];
    subLayer.bounds = CGRectMake(0, 0, 2, 5);
    subLayer.position = CGPointMake(_pieChart.centerX+5, 0);
    subLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    
    [clockLayer addSublayer:subLayer];
    clockLayer.instanceCount = 24;
    clockLayer.instanceTransform = CATransform3DMakeRotation((2*M_PI)/24, 0, 0, 1.0);
    
    
    CGPoint center = clockLayer.position;
    
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

#pragma mark - ZFPieChartDataSource

- (NSArray *)valueArrayInPieChart:(ZFPieChart *)chart{
    NSMutableArray *value = [NSMutableArray array];
    for ( HourlyRecordDataShow *show in _data ){
        NSLog(@"minettt: -----  %@",show.minuteStr);
        [value addObject:show.minuteStr];
    }
    
    return [NSArray arrayWithArray:value];
}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart{
    NSMutableArray *value = [NSMutableArray array];
    for ( HourlyRecordDataShow *show in _data ){
        [value addObject:show.eventTypeModel.color];
        
        NSLog(@"colorr: -----  %@",[show.eventTypeModel.color hexString]);

    }
    return [NSArray arrayWithArray:value];
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index{
    NSLog(@"第%ld个",(long)index);
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
