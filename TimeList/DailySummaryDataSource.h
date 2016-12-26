//
//  DailySummaryDataSource.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/26.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailySummaryDataSource : NSObject


@property (nonatomic, readwrite, strong) NSDate *lastSaveDate;

@property (nonatomic, readwrite, strong) NSString *summaryContent;

@property (nonatomic, readwrite, strong) NSString *identifier;

+ (DailySummaryDataSource *)createWithDate:(NSDate *)date;

@end
