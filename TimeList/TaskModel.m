//
//  TaskModel.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskModel.h"
#import "TaskModel+FMDB.h"

@implementation TaskModel

- (instancetype)init
{
    self = [super init];
    if ( !self ) return nil;
    _importance = -1;
    _title = @"";
    _localId = @"1";
    _status = TaskDefaultStauts;
    _createDate = [NSDate date];
    [TaskModel insert:self];
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


@end
