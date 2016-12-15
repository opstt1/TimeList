//
//  TaskModel.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel

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
    return NO;
}


@end
