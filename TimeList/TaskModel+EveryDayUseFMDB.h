//
//  TaskModel+EveryDayUseFMDB.h
//  TimeList
//
//  Created by LiHaomiao on 2017/3/8.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "TaskModel.h"

@interface TaskModel (EveryDayUseFMDB)

+ (void)everyDayCreatSqliteTable;

-(BOOL)everyDayTaskInsertSQL;
-(BOOL)everyDayTaskUpadteSQL;
-(BOOL)everyDayTaskRemoveSQL;

+ (NSArray *)everyDayTaskFindAllData;

@end
