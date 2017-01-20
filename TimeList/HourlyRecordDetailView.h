//
//  HourlyRecordDetailView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/20.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@class HourlyRecordDataSource;

@interface HourlyRecordDetailView : BaseView

+ (HourlyRecordDetailView *)createWithData:(HourlyRecordDataSource *)data;

@end
