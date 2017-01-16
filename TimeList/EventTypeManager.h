//
//  EventTypeManager.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLDataSource.h"

@class EventTypeModle;

@interface EventTypeManager : TLDataSource

@property (nonatomic, readonly, copy) NSArray *colors;

@property (nonatomic, readonly, copy) NSArray *unUseColors;



+ (instancetype)shareManager;


@end
