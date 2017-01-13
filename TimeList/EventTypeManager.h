//
//  EventTypeManager.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EventTypeModle;

@interface EventTypeManager : NSObject

@property (nonatomic, readonly, copy) NSArray *colors;

@property (nonatomic, readonly, copy) NSArray *eventTypes;

@property (nonatomic, readonly, copy) NSArray *unUseColors;



+ (instancetype)shareManager;


- (void)insertEventModle:(EventTypeModle *)model;

@end
