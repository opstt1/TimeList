//
//  DailySummaryDataSource+FMDB.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/26.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "DailySummaryDataSource.h"

@interface DailySummaryDataSource (FMDB)

+ (void)createSqliteTable;
- (BOOL)insertSQL;
- (BOOL)upadteSQL;
+ (NSArray *) findOfStartDate: (NSDate *) start toDate:(NSDate *) toDate;

@end
