//
//  DailySummaryDataSource.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/26.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "DailySummaryDataSource.h"
#import "FMDBManager.h"
#import "DailySummaryDataSource+FMDB.h"
#import "Constants.h"

@interface DailySummaryDataSource()


@end

@implementation DailySummaryDataSource

+ (DailySummaryDataSource *)createWithDate:(NSDate *)date
{
    
    NSDate *begin = [date beginningOfDay];
    NSDate *end = [date endOfDay];
    NSArray *array =  [DailySummaryDataSource findOfStartDate:begin toDate:end];
    
    if ( array.count > 0 ){
        
        return [array firstObject];
    }
    
    DailySummaryDataSource *dataSource = [[DailySummaryDataSource alloc] init];
    
    [DailySummaryDataSource createSqliteTable];
    [dataSource insertSQL];
    
    return dataSource;
}


- (instancetype)init
{
    self = [super init];
    if ( !self ) return nil;
    
    _identifier = [NSDate stringFromDay:[NSDate date] formatStr:@"yyyy-MM-dd"];
    _lastSaveDate = [NSDate date];
    _summaryContent = @"";
    
    return self;
    
}
@end
