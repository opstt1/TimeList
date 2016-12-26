//
//  DailySummaryDataSource+FMDB.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/26.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "DailySummaryDataSource+FMDB.h"
#import "FMDBManager.h"

DailySummaryDataSource *rs2DailySummary(FMResultSet *rs){
    DailySummaryDataSource *obj = [[DailySummaryDataSource alloc] init];
    
    obj.lastSaveDate = [rs dateForColumn:@"lastSaveDate"];
    obj.summaryContent = [rs stringForColumn:@"summaryContent"];
    obj.identifier = [rs stringForColumn:@"identifier"];
    
    return obj;
}

@implementation DailySummaryDataSource (FMDB)

+ (void)createSqliteTable {
    FMDatabase *db = [[FMDBManager shareManager] connect];
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'",@"daily_summary"];
    FMResultSet *rs = [db executeQuery:existsSql];
    
    if ( [rs next] ){
        NSInteger count = [rs intForColumn:@"countNum"];
        NSLog(@"The table count: %d", (int)count);
        if (count == 1) {
            NSLog(@"daily_summary table is existed.");
            return;
        }
        NSLog(@"daily_summary is not existed.");
    }
    [rs close];
    
    NSLog(@"daily_summary create table ....");
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS daily_summary(identifier text, lastSaveDate date, summaryContent text);"];
    
    NSLog(@"daily_summary --sql: \n %@", sql);
    NSLog(@"daily_summary execute sql ....");
    
    if([db executeUpdate:sql]) {
        NSLog(@"daily_summary create table succes....");
        
        //        [KVNProgress showWithStatus:@"create table succes...."];
    } else {
        NSLog(@"daily_summary fail to execute update sql..");
    }
    
    [db close];

}

- (BOOL)insertSQL
{
    NSLog(@"daily_summary insert logkeeper");
    NSLog(@"daily_summary convert int value to NSNumber ...");
    
    NSString *sql = @"insert into daily_summary(identifier, lastSaveDate, summaryContent) values(?, ?, ?)";
    FMDatabase *db = [[FMDBManager shareManager] connect];
    
    if ( db == nil ){
        NSLog(@"daily_summary fail to creat db...");
    }
    
    BOOL ret = [db executeUpdate:sql, self.identifier, self.lastSaveDate, self.summaryContent];
    if ( ret ){
        NSLog(@"daily_summary success insertSQL_Summary!!");
    }
    
    [db close];
    
    return ret;
}

- (BOOL)upadteSQL
{
    NSLog(@"daily_summary update logkeeper content");
    NSString *sql = @"update daily_summary set identifier = ?, lastSaveDate = ?, summaryContent = ?  where identifier = ?";
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.identifier, self.lastSaveDate, self.summaryContent, self.identifier];
    
    [db close];
    return ret;
}

+ (NSArray *) findOfStartDate: (NSDate *) start toDate:(NSDate *) toDate
{
    NSLog(@"daily_summary find logkeeper between date ....");
    NSString *sql = @"select * from daily_summary where lastSaveDate between ? and ?";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    FMResultSet *rs = [db executeQuery:sql, start, toDate];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:32];
    while ([rs next]) {
        DailySummaryDataSource *dataSource = rs2DailySummary(rs);
        [array addObject:dataSource];
    }
    
    [rs close];
    [db close];
    
    return array;
}

@end
