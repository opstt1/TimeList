//
//  EventTypeModel+FMDB.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeModel+FMDB.h"
#import "FMDBManager.h"

@implementation EventTypeModel (FMDB)

EventTypeModel *rs2EventTypeModel (FMResultSet *rs){
    EventTypeModel *obj = [[EventTypeModel alloc] init];
    
    obj.identifier = [rs stringForColumn:@"identifier"];
    obj.title = [rs stringForColumn:@"title"];
    obj.isDefault = [rs boolForColumn:@"isDefault"];
    
    return obj;
}


+ (void) createSqliteTable
{
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", @"EventTypeModel" ];

    FMResultSet *rs = [db executeQuery:existsSql];
    
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        if (count == 1) {
            return;
        }
            }
    [rs close];
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS EventTypeModel(identifier text, title text,isDefault bool );"];

    [db executeUpdate:sql];

    [db close];
}

+ (NSArray *)findAll
{
    NSLog(@" EventTypeModel findAll...");
    
    NSString *sql = @"select * from EventTypeModel";
    FMDatabase *db = [[FMDBManager shareManager] connect];
    FMResultSet *rs = [db executeQuery:sql];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:32];
    while ([rs next]) {
        EventTypeModel *EventTypeModel = rs2EventTypeModel(rs);
        [array addObject:EventTypeModel];
    }
    
    [rs close];
    [db close];
    
    return array;

}
- (BOOL)insertSQL
{
    NSLog(@" EventTypeModel insertSQL...");
    
    NSNumber *isDefault = [NSNumber numberWithBool:self.isDefault];
    
    NSString *sql = @"insert into EventTypeModel(identifier, title, isDefault) values(?, ?, ?)";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    if (db == nil) {
        NSLog(@"fail to create db..");
    }
    
    BOOL ret = [db executeUpdate:sql, self.identifier,self.title, isDefault];
    if ( ret ){
        NSLog(@"success insertSQL");
    }
    [db close];
    
    return ret;
}

- (BOOL)upadteSQL
{
    NSLog(@" EventTypeModel upadteSQL...");
    
    NSString *sql = @"update EventTypeModel set identifier = ?,title = ?, isDefault = ?  where identifier = ?";
    NSNumber *isDefault = [NSNumber numberWithBool:self.isDefault];
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.identifier, self.title, isDefault, self.identifier];
    
    [db close];
    return ret;
}

- (BOOL)removeSQL
{
//    if ( self.isDefault ){
//        return NO;
//    }
    NSLog(@" EventTypeModel removeSQL...");
    
    NSString *sql = @"delete from EventTypeModel where identifier = ?";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.identifier];
    
    [db close];
    
    return ret;
}


@end
