//
//  HourlyRecordCreateView.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/27.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@class HourlyRecordModel;

typedef void(^HourlyRecordCreateBlock)(HourlyRecordModel *model);

@interface HourlyRecordCreateView : BaseView

@property (nonatomic, readwrite, copy) HourlyRecordCreateBlock complete;

+ (HourlyRecordCreateView *)createWithComplete:(HourlyRecordCreateBlock)complete;

+ (HourlyRecordCreateView *)create;


+ (HourlyRecordCreateView *)editWithModel:(HourlyRecordModel *)model complete:(HourlyRecordCreateBlock)complete;


@end
