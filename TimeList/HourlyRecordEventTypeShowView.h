//
//  HourlyRecordEventTypeShowView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/19.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"
#import "HourlyRecordModel.h"

@interface HourlyRecordEventTypeShowView : BaseView

+ (HourlyRecordEventTypeShowView *)creatWithFrame:(CGRect)frame hourlyRecordData:(HourlyRecordDataSource *)data;

@end
