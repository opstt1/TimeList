//
//  DailyTaskRecordView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/4.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@class TaskModel;

@interface DailyTaskRecordView : BaseView

@property (nonatomic, readonly, assign) CGFloat viewHeight;

+ (DailyTaskRecordView *)createWithTaskModel:(TaskModel *)taskModel;

@end
