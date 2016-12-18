//
//  NSArray+Toolkit.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/16.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "NSArray+Toolkit.h"

@implementation NSArray (Toolkit)

- (BOOL)isOutArrayRangeAtIndex:(NSInteger)index
{
    if ( index == 0 ){
        return NO;
    }
    
    if ( index < 0 || index >= self.count ){
        return YES;
    }
    return NO;
}
@end
