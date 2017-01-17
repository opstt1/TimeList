//
//  HourlyRecordModel+FMDB.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/29.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordModel.h"

@interface HourlyRecordModel (FMDB)

+ (void)createSqliteTable;
- (BOOL)insertSQL;
- (BOOL)upadteSQL;
- (BOOL)removeSQL;

+ (NSArray *) findOfStartDate: (NSDate *) start toDate:(NSDate *) toDate;
+ (void)addCollmn;

@end
