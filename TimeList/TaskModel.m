//
//  TaskModel.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskModel.h"
#import "TaskModel+FMDB.h"
#import "Constants.h"


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

@implementation TaskModel

NSString * const TaskModelStatusKey = @"status";
NSString * const TaskModelImportanceKey = @"importance";
NSString * const TaskModelLocalIdKey = @"localId";

- (instancetype)init
{
    self = [super init];
    if ( !self ) return nil;
    _importance = -1;
    _title = @"";
    _localId = [NSDate stringFromDay:[NSDate date]];
    _status = TaskDefaultStauts;
    _createDate = [NSDate date];
    _desc = @"";
    _summarize = @"";
    _startTime = [NSDate date];
    _leftLimitMargin = 75+75.0f;
    _rightLimitMargin = 75.0f;
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    TaskModel *model = [[TaskModel allocWithZone:zone] init];
    if( !model ){
        return nil;
    }
    model.importance = _importance;
    model.title = [_title mutableCopy];
    model.status = _status;
    model.desc = [_desc mutableCopy];
    model.summarize = [_summarize mutableCopy];
    model.startTime = [[NSDate alloc] initWithTimeInterval:0.0 sinceDate:_startTime];
    return model;
}

- (void)setImportance:(NSInteger)importance
{
    if ( importance > 10 ){
        importance = 10;
    }
    if ( importance < 0 ){
        importance = 0;
    }
    
    _importance = importance;
    _fullStarCount = importance / 2;
    _hasHalfStar = importance % 2;
}

- (void)setStatus:(TaskModelStatus)status
{
    _status = status;
    if ( _status == TaskHasBeenDone ){
        _rightLimitMargin = 0;
    }else if ( _status == TaskUndone ){
        _rightLimitMargin = 75.0f;
    }
}

- (BOOL)dataIntegrity
{
    if ( _importance == -1 ){
        return NO;
    }
    
    if ( !_title || [_title isEqualToString:@""] ){
        return NO;
    }
    
    if ( _status == TaskDefaultStauts ){
        return NO;
    }
    return YES;
}

- (void)allocIdentifier
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *nowId = [userDefault stringForKey:userDefautlIdKey];
    NSInteger indentifier = [nowId integerValue];
    NSString *nextIdentifier = [NSString stringWithFormat:@"%d",(int)++indentifier];
    self.localId = nextIdentifier;
    [userDefault setObject:nextIdentifier forKey:userDefautlIdKey];
    [userDefault synchronize];
    
}
- (void)createSuccess
{
    [self allocIdentifier];
    self.createDate = [NSDate date];
    [TaskModel insert:self];
}

- (void)remove
{
    [TaskModel remove:self];
}
@end
