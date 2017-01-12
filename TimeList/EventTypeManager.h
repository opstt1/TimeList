//
//  EventTypeManager.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventTypeManager : NSObject

@property (nonatomic, readonly, copy) NSArray *colors;

@property (nonatomic, readonly, copy) NSArray *eventTypes;

+ (instancetype)shareManager;


@end
