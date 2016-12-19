//
//  TaskModel+FMDB.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/16.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskModel+FMDB.h"
#import "FMDBManager.h"
#import "KVNProgress.h"

TaskModel * rs2logkeeper(FMResultSet *rs) { 
    
    TaskModel *obj = [[TaskModel alloc] init];

    obj.localId     = [rs stringForColumn:@"local_id"];
    
    obj.title       = [rs stringForColumn:@"title"];
    obj.status      = [rs intForColumn:@"status"];
    obj.importance  = [rs intForColumn:@"importance"];
    obj.desc        = [rs stringForColumn:@"desc"];
    obj.startTime   = [rs dateForColumn:@"start_date"];
    obj.summarize   = [rs stringForColumn:@"summarize"];
    obj.createDate  = [rs dateForColumn:@"create_date"];
    
    return obj;
}

@implementation TaskModel (FMDB)

+ (void) createSqliteTable {
    
    NSLog(@"check table is exists?");
    FMDatabase *db = [[FMDBManager shareManager] connect];
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", @"log_keepers" ];
    //NSLog(@"%@", existsSql);
    
    FMResultSet *rs = [db executeQuery:existsSql];
    
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        NSLog(@"The table count: %d", (int)count);
        if (count == 1) {
            NSLog(@"log_keepers table is existed.");
            return;
        }
        
        NSLog(@"log_keepers is not existed.");
    }
    [rs close];
    
    
    NSLog(@"create table ....");
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"log_keepers_table" ofType:@"sql"];
    NSLog(@"logkeeper sql file: %@", filePath);
    
    NSError *error;
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS log_keepers(local_id text, title text, status INTEGER, importance INTEGER, desc text, start_date date, summarize text, create_date date);"];
    //[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
//    if (error != nil) {
//        NSLog(@"fail to read sql file: %@", [error description]);
//        return;
//    }
//    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS log_keepers id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
    NSLog(@"--sql: \n %@", sql);
    NSLog(@"execute sql ....");
    if([db executeUpdate:sql]) {
        NSLog(@"create table succes....");
        
//        [KVNProgress showWithStatus:@"create table succes...."];
    } else {
        NSLog(@"fail to execute update sql..");
    }
    
    
    [db close];
}

+ (BOOL) insert: (TaskModel *) logkeeper {
    return [logkeeper insertSQL];
}

+ (BOOL) updateContent:(TaskModel *)taskModel
               localId: (NSString *)localId
{
    return [taskModel upadteSQL];
}

+ (BOOL) remove: (TaskModel *) logkeeper
{
    return [logkeeper removeSQL];
}

- (BOOL)insertSQL
{
    NSLog(@"insert logkeeper");
    NSLog(@"convert int value to NSNumber ...");

    NSNumber *statusNum = [NSNumber numberWithInt:self.status];
    NSNumber *importanceNum = [NSNumber numberWithInteger:self.importance];
    
    NSString *sql = @"insert into log_keepers(local_id, title, status, importance, desc, start_date, summarize, create_date) values(?, ?, ?, ?, ?, ?, ?, ?)";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    if (db == nil) {
        NSLog(@"fail to create db..");
    }
    BOOL ret = [db executeUpdate:sql, self.localId, self.title,statusNum, importanceNum,self.desc, self.startTime, self.summarize, self.createDate];
    if ( ret ){
        NSLog(@"success insertSQL");
    }
    [db close];
    
    return ret;
}

- (BOOL)upadteSQL
{
    NSLog(@"update logkeeper content");
    NSString *sql = @"update log_keepers set local_id = ?,title = ?, status = ?, importance = ?, desc = ?, start_date = ?, summarize = ?, create_date = ?  where local_id = ?";
    NSNumber *statusNum = [NSNumber numberWithInt:self.status];
    NSNumber *importanceNum = [NSNumber numberWithInteger:self.importance];
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.localId, self.title,statusNum, importanceNum,self.desc, self.startTime, self.summarize, self.createDate, self.localId];
    
    [db close];
    return ret;

}

- (BOOL)removeSQL
{
    NSLog(@"remove logkeeper: %@", self.localId);
    NSString *sql = @"delete from log_keepers where local_id = ?";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.localId];
    
    [db close];
    
    return ret;
}


+ (TaskModel *) findById:(NSString *)localId {
    NSLog(@"find logkeeper by id: %@", localId);
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    FMResultSet *rs = [FMResultSet new];
     rs = [db executeQuery:@"select * from log_keepers where local_id = ?", localId];
    
    TaskModel *ret;
    
    if (rs.next) {
        ret = rs2logkeeper(rs);
    }
    
    [db close];
    return ret;
}

+ (TaskModel *) findByCreateDate:(NSDate *)createDate {
    NSLog(@"find logkeeper by id: %@", createDate);
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    FMResultSet *rs = [db executeQuery:@"select * from log_keepers where create_date = ?", createDate];
    
    TaskModel *ret;
    
    if ([rs next]) {
        ret = rs2logkeeper(rs);
    }
    
    [db close];
    return ret;
}

+ (NSArray *) findOfStartDate: (NSDate *) start toDate:(NSDate *) toDate {
    NSLog(@"find logkeeper between date ....");
    NSString *sql = @"select * from log_keepers where create_date between ? and ?";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    FMResultSet *rs = [db executeQuery:sql, start, toDate];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:32];
    while ([rs next]) {
        TaskModel *logkeeper = rs2logkeeper(rs);
        [array addObject:logkeeper];
    }
    
    [rs close];
    [db close];
    
    return array;
}
@end
