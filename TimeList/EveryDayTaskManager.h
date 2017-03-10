//
//  EveryDayTaskManager.h
//  TimeList
//
//  Created by LiHaomiao on 2017/3/9.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLDataSource.h"

@interface EveryDayTaskManager : NSObject

@property (nonatomic, readwrite, strong) TLDataSource *dataSource;

+ (EveryDayTaskManager *)shareManager;

@end
