//
//  TaskAlwaysUseManager.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/30.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLDataSource.h"

@interface TaskAlwaysUseManager : NSObject

@property (nonatomic, readwrite, strong) TLDataSource *dataSource;

+ (TaskAlwaysUseManager *)shareManager;


@end
