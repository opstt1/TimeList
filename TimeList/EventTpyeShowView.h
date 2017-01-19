//
//  EventTpyeShowView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/19.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@class HourlyRecordDataSource;

@interface EventTpyeShowView : BaseView

+ (EventTpyeShowView *)createWithData:(HourlyRecordDataSource *)data;

@end
