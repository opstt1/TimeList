//
//  TaskModel+AlwaysUseFMDB.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/30.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskModel+AlwaysUseFMDB.h"
#import "FMDBManager.h"

@implementation TaskModel (AlwaysUseFMDB)

+ (void)alwaysCreateSqliteTable
{
    NSLog(@"task_alwaysUse check table is exists?");
    FMDatabase *db = [[FMDBManager shareManager] connect];
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", @"task_alwaysUse" ];
    
    FMResultSet *rs = [db executeQuery:existsSql];
    
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        NSLog(@"The table count: %d", (int)count);
        if (count == 1) {
            NSLog(@"task_alwaysUse table is existed.");
            return;
        }
        
        NSLog(@"task_alwaysUse is not existed.");
    }
    [rs close];
    
    
    NSLog(@"task_alwaysUse create table ....");

    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS task_alwaysUse(local_id text, title text, status INTEGER, importance INTEGER, desc text, start_date date, summarize text, create_date date);"];
    
    NSLog(@"task_alwaysUse --sql: \n %@", sql);
    NSLog(@"task_alwaysUse execute sql ....");
    
    if([db executeUpdate:sql]) {
        NSLog(@"task_alwaysUsecreate table succes....");
    } else {
        NSLog(@"task_alwaysUse fail to execute update sql..");
    }
    
    
    [db close];
}

- (BOOL)alwaysInsertSQL
{
    NSLog(@"task_alwaysUse insert logkeeper");
    NSLog(@"task_alwaysUse convert int value to NSNumber ...");
    
    NSNumber *statusNum = [NSNumber numberWithInt:self.status];
    NSNumber *importanceNum = [NSNumber numberWithInteger:self.importance];
    
    NSString *sql = @"insert into task_alwaysUse(local_id, title, status, importance, desc, start_date, summarize, create_date) values(?, ?, ?, ?, ?, ?, ?, ?)";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    if (db == nil) {
        NSLog(@"task_alwaysUse fail to create db..");
    }
    BOOL ret = [db executeUpdate:sql, self.localId, self.title,statusNum, importanceNum,self.desc, self.startTime, self.summarize, self.createDate];
    if ( ret ){
        NSLog(@"stask_alwaysUse uccess insertSQL");
    }
    [db close];
    
    return ret;
}


- (BOOL)alwaysUpadteSQL
{
    NSLog(@"task_alwaysUse update logkeeper content");
    NSString *sql = @"update task_alwaysUse set local_id = ?,title = ?, status = ?, importance = ?, desc = ?, start_date = ?, summarize = ?, create_date = ?  where local_id = ?";
    NSNumber *statusNum = [NSNumber numberWithInt:self.status];
    NSNumber *importanceNum = [NSNumber numberWithInteger:self.importance];
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.localId, self.title,statusNum, importanceNum,self.desc, self.startTime, self.summarize, self.createDate, self.localId];
    
    [db close];
    return ret;
    
}

- (BOOL)alwaysRemoveSQL
{
    NSLog(@"task_alwaysUse remove logkeeper: %@", self.localId);
    NSString *sql = @"delete from task_alwaysUse where local_id = ?";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.localId];
    
    [db close];
    
    return ret;
}

+ (NSArray *)alwaysFindAllData
{
    NSLog(@"find task_alwaysUse date ....");
    NSString *sql = @"select * from task_alwaysUse";
    
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
