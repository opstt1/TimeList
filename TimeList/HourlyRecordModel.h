//
//  HourlyRecordModel.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/28.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TLDataSource.h"

@interface HourlyRecordModel : NSObject


@property (nonatomic, readwrite, copy) NSString *content;

@property (nonatomic, readwrite, strong) NSDate *createDate;

@property (nonatomic, readwrite, strong) NSDate *startDate;

@property (nonatomic, readwrite, strong) NSDate *endDate;

@property (nonatomic, readwrite, copy) NSString *identifier;

#pragma mark - calculate property

@property (nonatomic, readwrite, copy) NSString *startTime;

@property (nonatomic, readwrite, copy) NSString *endTime;

@property (nonatomic, readonly, assign) CGFloat cellHeight;


@end



@interface HourlyRecordDataSource : TLDataSource

+ (HourlyRecordDataSource *)createWithDate:(NSDate *)date;

@end
