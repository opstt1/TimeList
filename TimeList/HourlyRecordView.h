//
//  HourlyRecordView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/5.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@interface HourlyRecordView : BaseView


@property (nonatomic, readonly, assign) CGFloat viewHeight;

+ (HourlyRecordView *)createWithDate:(NSDate *)date content:(NSString *)content;

@end
