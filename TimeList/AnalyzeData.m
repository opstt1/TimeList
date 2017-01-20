//
//  AnalyzeData.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/19.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "AnalyzeData.h"
#import "Constants.h"

#pragma mark - HourlyRecordDataShow

@interface HourlyRecordDataShow()

@property (nonatomic, readwrite, assign) NSInteger showMinute;
@property (nonatomic, readwrite, copy) NSString *minuteStr;
@property (nonatomic, readwrite, copy) NSString *timeShow;

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

- (void)setShowMinute:(NSInteger)showMinute
{
    _showMinute = showMinute;
    
    NSString *str = @"";
    
    if ( _showMinute / 60 > 0 ){
        if ( _showMinute % 60 != 0 ){
            str = [NSString stringWithFormat:@"%d 小时 %d 分种",(int)_showMinute/60,(int)_showMinute % 60];
        }else{
            str = [NSString stringWithFormat:@"%d 小时",(int)_showMinute/60];
        }
    }else{
        str = [NSString stringWithFormat:@"%d 分种",(int)_showMinute];
    }
    
    _timeShow = str;
}

@end

#pragma mark - HourlyRecordEventTypeShow

@interface HourlyRecordEventTypeShow ()

@property (nonatomic, readwrite, assign) NSInteger showMinute;
@property (nonatomic, readwrite, copy) NSString *minuteStr;
@property (nonatomic, readwrite, copy) NSString *timeShow;

@end

@implementation HourlyRecordEventTypeShow

+ (HourlyRecordEventTypeShow *)createWithEventTypeModel:(EventTypeModel *)model
{
    HourlyRecordEventTypeShow *show = [[HourlyRecordEventTypeShow alloc] init];
    show.identifier = model.identifier;
    show.title = model.title;
    show.showMinute = 0;
    
    return show;
}

- (void)setShowMinute:(NSInteger)showMinute
{
    _showMinute = showMinute;
    _minuteStr = [NSString stringWithFormat:@"%d",(int)showMinute];
    NSString *str = @"";
    
    if ( _showMinute / 60 > 0 ){
        if ( _showMinute % 60 != 0 ){
            str = [NSString stringWithFormat:@"%d 小时 %d 分种",(int)_showMinute/60,(int)_showMinute % 60];
        }else{
            str = [NSString stringWithFormat:@"%d 小时",(int)_showMinute/60];
        }
    }else{
        str = [NSString stringWithFormat:@"%d 分种",(int)_showMinute];
    }
    
    _timeShow = str;
}

@end

#pragma mark - AnalyzeData

@implementation AnalyzeData

//处理数据，用于统计
+ (NSArray *)hourlyRecordAnalyzeData:(HourlyRecordDataSource *)data
{
    NSMutableArray *timeArray = [NSMutableArray array];
    if ( !data || data.count <= 0 ){
        return [NSArray array];
    }
    
    NSInteger residueMinutes = allMinutes;
    
    HourlyRecordModel *first = [data objectAtInde:data.count-1];
    NSLog(@"secont: ----%@ %d",first.startTime,(int)[first.startDate timeIntervalSinceDate:[first.startDate beginningOfDay]]/60);
    NSInteger minute = [first.startDate minutesIntervalSinceDate:[first.startDate beginningOfDay]];
    if( minute > 0 ){
        //如果每天00:00开始到第一条记录之间有空隙，计为未知
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
                minute = [preModel.endDate minutesIntervalSinceDate:model.startDate];
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
        //如果每天最后一项任务到23:59之间有空隙，计为未知
        HourlyRecordModel *preModel = [data objectAtInde:0];
        minute = [preModel.endDate minutesIntervalSinceDate:[preModel.endDate endOfDay]];
        HourlyRecordDataShow *show = [HourlyRecordDataShow createUnknownShowWitMinute:minute startDate:preModel.endDate endDate:[preModel.endDate endOfDay]];
        [timeArray addObject:show];
    }
    
   return [NSArray arrayWithArray:timeArray];
}

+ (NSArray *)eventTypeAnalyzeData:(HourlyRecordDataSource *)data
{
    if ( !data || data.count <= 0 ){
        return [NSArray array];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *unKonwType = @"";
    
    for ( int i = 0; i < data.count; ++i ){
        HourlyRecordModel *model = [data objectAtInde:i];
        BOOL isSame = NO;
        for (EventTypeModel *data in array){
            if ( [data.identifier isEqualToString:model.eventTypeModel.identifier] ){
                isSame = YES;
                break;
            }
        }
        if ( !isSame ){
            [array addObject:model.eventTypeModel];
            if ( [model.eventTypeModel.identifier isEqualToString:[[UIColor grayColor] hexString]] ){
                unKonwType = [[UIColor grayColor] hexString];
            }
        }
    }
    
    if ( [unKonwType isEqualToString:@""] ){
        EventTypeModel *model = [[EventTypeModel alloc] init];
        model.title = @"未知";
        model.identifier = [[UIColor grayColor] hexString];
        [array addObject:model];
    }
    
    for ( EventTypeModel *data in array ){
        NSLog(@"ddd: %@ %@",data.identifier, data.title);
    }
    
    return [NSArray arrayWithArray:array];
}


+ (NSArray *)hourlyRecordTypeAnalyzeData:(HourlyRecordDataSource *)data
{
    NSMutableArray *types = [NSMutableArray arrayWithArray:[self eventTypeAnalyzeData:data]];
    NSMutableArray *hourlyRecord = [NSMutableArray arrayWithArray:[self hourlyRecordAnalyzeData:data]];
    NSMutableArray *array = [NSMutableArray array];
    
    [types enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HourlyRecordEventTypeShow *show = [HourlyRecordEventTypeShow createWithEventTypeModel:obj];
        [array addObject:show];

    }];
    
    [hourlyRecord enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HourlyRecordDataShow *show = (HourlyRecordDataShow *)obj;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stops) {
            HourlyRecordEventTypeShow *typeShow = (HourlyRecordEventTypeShow *)obj;
            if ( [show.eventTypeModel.identifier isEqualToString:typeShow.identifier] ){
                typeShow.showMinute = typeShow.showMinute + show.showMinute;
                *stops = YES;
            }
        }];
        
    }];
    
    return [NSArray arrayWithArray:array];
}
@end
