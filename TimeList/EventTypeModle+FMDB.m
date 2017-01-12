//
//  EventTypeModle+FMDB.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeModle+FMDB.h"
#import "FMDBManager.h"

@implementation EventTypeModle (FMDB)

EventTypeModle *rs2EventTypeModle (FMResultSet *rs){
    EventTypeModle *obj = [[EventTypeModle alloc] init];
    
    obj.identifier = [rs stringForColumn:@"identifier"];
    obj.title = [rs stringForColumn:@"title"];
    obj.isDefault = [rs boolForColumn:@"isDefault"];
    
    return obj;
}


+ (void) createSqliteTable
{
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", @"EventTypeModle" ];

    FMResultSet *rs = [db executeQuery:existsSql];
    
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        if (count == 1) {
            return;
        }
            }
    [rs close];
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS EventTypeModle(identifier text, title text,isDefault bool );"];

    [db executeUpdate:sql];

    [db close];
}

+ (NSArray *)findAll
{
    
    NSString *sql = @"select * from EventTypeModle";
    FMDatabase *db = [[FMDBManager shareManager] connect];
    FMResultSet *rs = [db executeQuery:sql];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:32];
    while ([rs next]) {
        EventTypeModle *eventTypeModle = rs2EventTypeModle(rs);
        [array addObject:eventTypeModle];
    }
    
    [rs close];
    [db close];
    
    return array;

}
- (BOOL)insertSQL
{

    NSNumber *isDefault = [NSNumber numberWithBool:self.isDefault];
    
    NSString *sql = @"insert into EventTypeModle(identifier, title, isDefault) values(?, ?, ?)";
    
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
    NSString *sql = @"update EventTypeModle set identifier = ?,title = ?, isDefault = ?  where identifier = ?";
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
    
    NSString *sql = @"delete from EventTypeModle where identifier = ?";
    
    FMDatabase *db = [[FMDBManager shareManager] connect];
    BOOL ret = [db executeUpdate:sql, self.identifier];
    
    [db close];
    
    return ret;
}


@end
