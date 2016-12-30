//
//  TaskModel+FMDB.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/16.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskModel.h"
#import "FMDB.h"



@interface TaskModel (FMDB)

+ (void) createSqliteTable;

+ (BOOL) insert: (TaskModel *) logkeeper;

+ (BOOL) updateContent:(TaskModel *)taskModel localId: (NSString *)localId;

+ (BOOL) remove: (TaskModel *) logkeeperId;

+ (TaskModel *) findById: (NSString *) localId;

+ (NSArray *) findOfStartDate: (NSDate *) start toDate:(NSDate *) toDate;


- (BOOL)upadteSQL;
- (BOOL)removeSQL;
- (BOOL)insertSQL;

@end
