//
//  EventTypeModle+FMDB.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeModle.h"

@interface EventTypeModle (FMDB)

+ (void) createSqliteTable;

+ (NSArray *) findAll;


- (BOOL)upadteSQL;
- (BOOL)removeSQL;
- (BOOL)insertSQL;

@end
