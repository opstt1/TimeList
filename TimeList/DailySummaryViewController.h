//
//  DailySummaryViewController.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/26.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^DailySumaryComplete) (BOOL complete);

@class DailySummaryDataSource;

@interface DailySummaryViewController : BaseViewController

- (void)data:(DailySummaryDataSource *)data complete:(DailySumaryComplete)complete;

@end
