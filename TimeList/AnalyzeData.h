//
//  AnalyzeData.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/19.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "HourlyRecordModel.h"


@interface HourlyRecordDataShow :HourlyRecordModel

@property (nonatomic, readonly, assign) NSInteger showMinute;
@property (nonatomic, readonly, copy) NSString *minuteStr;
@property (nonatomic, readonly, copy) NSString *timeShow;

@end

@interface HourlyRecordEventTypeShow : EventTypeModel

@property (nonatomic, readonly, assign) NSInteger showMinute;
@property (nonatomic, readonly, copy) NSString *minuteStr;
@property (nonatomic, readonly, copy) NSString *timeShow;


@end

@interface AnalyzeData : NSObject

/**
 分析时间记录数据

 @param NSArray 时间记录数据
 @return 分析后的数据
 */
+ (NSArray *)hourlyRecordAnalyzeData:(HourlyRecordDataSource *)data;


/**
 分析归纳任务类型

 @param data 时间记录数据
 @return 任务类型数组
 */
+ (NSArray *)eventTypeAnalyzeData:(HourlyRecordDataSource *)data;



/**
 分析每种类型的任务在总时间内所占的比例

 @param data 时间记录数据
 @return 每人类型数据数组
 */
+ (NSArray *)hourlyRecordTypeAnalyzeData:(HourlyRecordDataSource *)data;

@end
