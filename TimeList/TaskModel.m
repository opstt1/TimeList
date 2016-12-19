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
    _localId = @"-1";
    _status = TaskDefaultStauts;
    _createDate = [NSDate date];
    _desc = @"";
    _summarize = @"";
    _startTime = [NSDate date];
    _leftLimitMargin = 80.0f;
    _rightLimitMargin = 75.0f;
    return self;
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
        _rightLimitMargin = -5;
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
    [TaskModel insert:self];
}

- (void)remove
{
    [TaskModel remove:self];
}
@end
