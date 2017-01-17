//
//  EventTypeModel+FMDB.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeModel.h"

@interface EventTypeModel (FMDB)

+ (void) createSqliteTable;

+ (NSArray *) findAll;


- (BOOL)upadteSQL;
- (BOOL)removeSQL;
- (BOOL)insertSQL;

@end
