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

@property (nonatomic, readwrite, strong) NSDate *creatDate;

@property (nonatomic, readwrite, copy) NSString *startTime;

@property (nonatomic, readwrite, copy) NSString *endTime;

@property (nonatomic, readonly, assign) CGFloat cellHeight;

@property (nonatomic, readwrite, strong) NSDate *startDate;

@property (nonatomic, readwrite, strong) NSDate *endDate;

@end



@interface HourlyRecordDataSource : TLDataSource


@end
