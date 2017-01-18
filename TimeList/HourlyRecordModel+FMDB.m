//
//  HourlyRecordModel+FMDB.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/29.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordModel+FMDB.h"
#import "FMDBManager.h"


HourlyRecordModel *rs2HourlyRecord(FMResultSet *rs){
    HourlyRecordModel *obj = [[HourlyRecordModel alloc] init];
    obj.eventTypeModel = [[EventTypeModel alloc] init];
    
    obj.content = [rs stringForColumn:@"content"];
    obj.createDate = [rs dateForColumn:@"createDate"];
    obj.identifier = [rs stringForColumn:@"identifier"];
    obj.startDate = [rs dateForColumn:@"startDate"];
    obj.endDate = [rs dateForColumn:@"endDate"];
    obj.eventTypeModel.title = [rs stringForColumn:@"typeTitle"] ?: @"";
    obj.eventTypeModel.identifier = [rs stringForColumn:@"typeIdentifier"] ?: @"";
    
    return obj;
}

@implementation HourlyRecordModel (FMDB)


+ (void)addCollmn
{
    FMDatabase *db = [[FMDBManager shareManager] connect];
    
    if ( ![db columnExists:@"typeIdentifier" inTableWithName:@"hourly_recorde_detail"]){
        [db executeUpdate:@"ALTER TABLE hourly_recorde_detail ADD COLUMN typeIdentifier text"];
        BOOL succsess = [db executeUpdate:@"ALTER TABLE hourly_recorde_detail ADD COLUMN typeIdentifier text"];
        if (succsess == YES) {
            NSLog(@"修改表成功 typeIdentifier");
        }else{
            NSLog(@"修改表失败 typeIdentifier");
        }
    }else{
        NSLog(@"typeIdentifier 存在");

    }
    
    if ( ![db columnExists:@"typeTitle" inTableWithName:@"hourly_recorde_detail"]){

        [db executeUpdate:@"ALTER TABLE hourly_recorde_detail ADD COLUMN typeTitle text"];
        BOOL success = [db executeUpdate:@"ALTER TABLE hourly_recorde_detail ADD COLUMN typeTitle text"];
        if (success == YES) {
            NSLog(@"修改表成功 typeTitle");
        }else{
            NSLog(@"修改表失败 typeTitle");
        }
    }else{
        NSLog(@"typeTitle 存在");
    }
}

+ (void)createSqliteTable
{
    FMDatabase *db = [[FMDBManager shareManager] connect];
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'",@"hourly_recorde_detail"];
    FMResultSet *rs = [db executeQuery:existsSql];
    
    if ( [rs next] ){
        
        NSInteger count = [rs intForColumn:@"countNum"];
        NSLog(@"The table count: %d", (int)count);
        if (count == 1) {
            NSLog(@"hourly_recorde_detail table is existed.");
            return;
        }
        NSLog(@"hourly_recorde_detail is not existed.");
    }
    [rs close];
    
    NSLog(@"hourly_recorde_detail create table ....");
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS hourly_recorde_detail(identifier text, createDate date, startDate date, endDate date, content text, typeIdentifier text, typeTitle text );"];
    
    NSLog(@"hourly_recorde_detail --sql: \n %@", sql);
    NSLog(@"hourly_recorde_detail execute sql ....");
    
    if([db executeUpdate:sql]) {
        NSLog(@"hourly_recorde_detail create table succes....");
        
        //        [KVNProgress showWithStatus:@"create table succes...."];
    } else {
        NSLog(@"hourly_recorde_detail fail to execute update sql..");
    }
    
    [db close];
    
}

- (BOOL)insertSQL
{
    NSLog(@"hourly_recorde_detail insert logkeeper");
    NSLog(@"hourly_recorde_detail convert int value to NSNumber ...");
    
    NSString *sql = @"insert into hourly_recorde_detail(identifier, createDate, startDate, endDate, content,typeIdentifier, typeTitle) values(?, ?, ?, ?, ?, ?, ?)";
    FMDatabase *db = [[FMDBManager shareManager] connect];
    
    if ( db == nil ){
        NSLog(@"hourly_recorde_detail fail to creat db...");
    }
    
    BOOL ret = [db executeUpdate:sql, self.identifier, self.createDate, self.startDate, self.endDate, self.content, self.eventTypeModel.identifier, self.eventTypeModel.title];
    if ( ret ){
        NSLog(@"hourly_recorde_detail success insertSQL_Hourly!!");
    }
    
    [db close];
    
    return ret;
}

- (BOOL)upadteSQL
{
    NSLog(@"hourly_recorde_detail update logkeeper content");
    NSString *sql = @"update hourly_recorde_detail set identifier = ?, createDate = ?, startDate = ?, endDate = ?, content = ?, typeIdentifier = ?, typeTitle = ? where identifier = ?";
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.identifier, self.createDate, self.startDate, self.endDate, self.content, self.eventTypeModel.identifier, self.eventTypeModel.title, self.identifier];
    
    [db close];
    return ret;
}

- (BOOL)removeSQL
{
    NSLog(@"remove hourly_recorde_detail: %@", self.identifier);
    NSString *sql = @"delete from hourly_recorde_detail where identifier = ?";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.identifier];
    
    [db close];
    
    return ret;
}


+ (NSArray *) findOfStartDate: (NSDate *) start toDate:(NSDate *) toDate
{
    NSLog(@"daily_summary find logkeeper between date ....");
    NSString *sql = @"select * from hourly_recorde_detail where createDate between ? and ?";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    FMResultSet *rs = [db executeQuery:sql, start, toDate];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:32];
    while ([rs next]) {
        HourlyRecordModel *dataSource = rs2HourlyRecord(rs);
        [array addObject:dataSource];
    }
    
    [rs close];
    [db close];
    
    return array;
}

@end
