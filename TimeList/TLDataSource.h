//
//  TLDataSource.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/28.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLDataSource;

@protocol TLDataSourceDelegate <NSObject>

@optional

- (void)TLDataSource:(TLDataSource *)dataSource update:(BOOL)update;

@end

@interface TLDataSource : NSObject

@property (nonatomic, readwrite, weak) id<TLDataSourceDelegate> delegate;

- (void)addModel:(id)model;

- (void)insertmodel:(id)model;

- (void)insertAtIndex:(NSInteger)index model:(id)model;

- (NSInteger)count;

- (id)objectAtInde:(NSUInteger)index;

- (id)deleteAtIndex:(NSInteger)index;

- (void)dataSourceWithArray:(NSArray *)array;

- (NSArray *)dataList;

@end
