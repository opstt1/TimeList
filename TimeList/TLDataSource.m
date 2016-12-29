//
//  TLDataSource.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/28.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TLDataSource.h"
#import "Constants.h"

@interface TLDataSource()

@property (nonatomic, readwrite, copy) NSArray *list;

@end

@implementation TLDataSource

- (instancetype)init
{
    self = [super init];
    if (!self ){
        return nil;
    }
    if ( !_list ){
        _list = [NSArray array];
    }
    return self;
}

- (void)addModel:(id)model
{
    if ( !model ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_list];
    [array addObject:model];
    [self p_setList:array];
}

- (void)insertmodel:(id)model
{
    [self insertAtIndex:0 model:model];
}

- (void)insertAtIndex:(NSInteger)index model:(id)model
{
    if ( [_list isOutArrayRangeAtIndex:index] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_list];
    [array insertObject:model atIndex:index];
    
    [self p_setList:array];
    
}

- (void)moveObjectFromeIndex:(NSInteger)fromeIndex toIndex:(NSInteger)toIndex
{
    if ( [_list isOutArrayRangeAtIndex:fromeIndex] || [_list isOutArrayRangeAtIndex:toIndex] ){
        return;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_list];
    id model = array[fromeIndex];
    [array removeObjectAtIndex:fromeIndex];
    [array insertObject:model atIndex:toIndex];
    [self p_setList:array];
}

- (id)deleteAtIndex:(NSInteger)index
{
    if (_list.count == 0 || [_list isOutArrayRangeAtIndex:index] ){
        return nil;
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:_list];
    id removeModel = [array objectAtIndex:index];
    [array removeObjectAtIndex:index];
    [self p_setList:array];
    return removeModel;
}

- (NSInteger)count
{
    return _list.count;
}

- (id)objectAtInde:(NSUInteger)index
{
    if( index >= _list.count ){
        return nil;
    }
    return  [_list objectAtIndex:index];
}

- (void)dataSourceWithArray:(NSArray *)array
{
    [self p_setList:array];
}

- (void)p_setList:(NSArray *)taskList
{
    self.list = [NSArray arrayWithArray:taskList];
    [self p_dataUpdate];
}

- (void)p_dataUpdate
{
    if ( _delegate && [_delegate respondsToSelector:@selector(TLDataSource:update:)] ){
        [_delegate TLDataSource:self update:YES];
    }
}
@end
