//
//  FMDBManager.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/16.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FMDBManager : NSObject


@property (nonatomic, readwrite, strong) FMDatabase *database;

+ (FMDBManager *)shareManager;

- (FMDatabase *) connect;

- (void)clearManager;

@end
