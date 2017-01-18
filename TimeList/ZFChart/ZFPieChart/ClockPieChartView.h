//
//  ClockPieChartView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/18.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@class HourlyRecordDataSource;

@interface ClockPieChartView : BaseView

+ (ClockPieChartView *)creatWithFrame:(CGRect)frame hourlyRecordData:(HourlyRecordDataSource *)data;


@end
