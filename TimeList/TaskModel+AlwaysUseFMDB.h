//
//  TaskModel+AlwaysUseFMDB.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/30.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskModel.h"

@interface TaskModel (AlwaysUseFMDB)

+ (void)alwaysCreateSqliteTable;
- (BOOL)alwaysUpadteSQL;
- (BOOL)alwaysRemoveSQL;
- (BOOL)alwaysInsertSQL;
+ (NSArray *)alwaysFindAllData;

@end
