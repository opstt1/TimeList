//
//  TaskModel+EveryDayUseFMDB.m
//  TimeList
//
//  Created by LiHaomiao on 2017/3/8.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "TaskModel+EveryDayUseFMDB.h"

@implementation TaskModel (EveryDayUseFMDB)

+ (void)everyDayCreatSqliteTable
{
    FMDatabase *db = [[FMDBManager shareManager] connect];
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", @"task_everyDayUse"];
    
    FMResultSet *rs = [db executeQuery:existsSql];
    
    if ( [rs next] ){
        NSInteger count = [rs intForColumn:@"countNum"];
        NSLog(@"The table count: %d", (int)count);
        if (count == 1) {
            NSLog(@"task_everyDayUse table is existed.");
            return;
        }
        
        NSLog(@"task_everyDayUse is not existed.");
    }
    [rs close];
    
    NSLog(@"task_everyDayUse create table .....");
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS task_everyDayUse(local_id text, title text, status INTEGER, importance INTEGER, desc text, start_date date, summarize text, create_date date);"];
    
    NSLog(@"task_everyDayUse execute sql ....");
    
    if ([db executeUpdate:sql] ){
        NSLog(@"task_alwaysUsecreate table succes....");
    } else {
        NSLog(@"task_alwaysUse fail to execute update sql..");
    }
    [db close];
}

-(BOOL)everyDayTaskInsertSQL
{
    NSNumber *statusNum = [NSNumber numberWithInt:self.status];
    NSNumber *importanceNum = [NSNumber numberWithInteger:self.importance];
    
    NSString *sql = @"insert into task_everyDayUse(local_id, title, status, importance, desc, start_date, summarize, create_date) values(?, ?, ?, ?, ?, ?, ?, ?)";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    if (db == nil) {
        NSLog(@"task_everyDayUse fail to create db..");
    }
    BOOL ret = [db executeUpdate:sql, self.localId, self.title,statusNum, importanceNum,self.desc, self.startTime, self.summarize, self.createDate];
    if ( ret ){
        NSLog(@"task_everyDayUse uccess insertSQL");
    }
    [db close];
    
    return ret;
}

- (BOOL)everyDayTaskUpadteSQL
{
    NSLog(@"task_everyDayUse update logkeeper content");
    NSString *sql = @"update task_everyDayUse set local_id = ?,title = ?, status = ?, importance = ?, desc = ?, start_date = ?, summarize = ?, create_date = ?  where local_id = ?";
    NSNumber *statusNum = [NSNumber numberWithInt:self.status];
    NSNumber *importanceNum = [NSNumber numberWithInteger:self.importance];
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.localId, self.title,statusNum, importanceNum,self.desc, self.startTime, self.summarize, self.createDate, self.localId];
    
    [db close];
    return ret;
}

- (BOOL)everyDayTaskRemoveSQL
{
    NSLog(@"task_everyDayUse remove logkeeper: %@", self.localId);
    NSString *sql = @"delete from task_everyDayUse where local_id = ?";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.localId];
    
    [db close];
    
    return ret;
}

+ (NSArray *)everyDayTaskFindAllData
{
    NSLog(@"find task_everyDayUse date ....");
    NSString *sql = @"select * from task_everyDayUse";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    FMResultSet *rs = [db executeQuery:sql];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:32];
    while ([rs next]) {
        TaskModel *logkeeper = rs2logkeeper(rs);
        [array addObject:logkeeper];
    }
    
    [rs close];
    [db close];
    
    return [NSArray arrayWithArray:array];
}

@end
