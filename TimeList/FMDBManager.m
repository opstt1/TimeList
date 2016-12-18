//
//  FMDBManager.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/16.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "FMDBManager.h"

#define kFMDBObvName @"Task.sqlite"

@implementation FMDBManager

+ (FMDBManager *)shareManager
{
    static FMDBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if ( !self ) return nil;
    
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filedPath = [docsdir stringByAppendingPathComponent:kFMDBObvName];
    _database = [FMDatabase databaseWithPath:filedPath];
    return self;
}

- (FMDatabase *)connect
{
    if ( [_database open] ) {
        return _database;
    }
    NSLog(@"fail to open db ......");
    return nil;
}


- (void)clearManager
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_database close] ){
            _database = nil;
        }
    });
}
@end
