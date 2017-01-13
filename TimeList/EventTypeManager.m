//
//  EventTypeManager.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeManager.h"
#import "Constants.h"
#import "EventTypeModle+FMDB.h"

#define color(x) [UIColor colorWithRGB:x]

@interface EventTypeManager()

@property (nonatomic, readwrite, copy) NSArray *colors;
@property (nonatomic, readwrite, copy) NSArray *unUseColors;
@property (nonatomic, readwrite, copy) NSArray *eventTypes;

@end

@implementation EventTypeManager

+ (instancetype)shareManager
{
    static EventTypeManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EventTypeManager alloc] init];
        [manager initColos];
    });
    
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if ( !self ){
        return nil;
    }
    
    [self initColos];
    
    //获取数据库中的任务类型
    [EventTypeModle createSqliteTable];
    _eventTypes = [EventTypeModle findAll];
    if ( _eventTypes.count <=0 ){
        //如果数据库中没有数据，那就是第一次加载，创建出默认的类型
        _eventTypes = [self createDefaultType];
    }
    
    for ( EventTypeModle *model in _eventTypes ){
        [self colorUsed:model.identifier];
    }
    
    return self;
}

//初始化颜色数组
- (void)initColos
{
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:color(0x0000FF),color(0x996633),color(0x00FFFF),color(0x00FF00),color(0xFF00FF),color(0xFF7F00),color(0x7F007F),color(0xFF0000),color(0xFFFF00), nil];

    self.colors = [NSArray arrayWithArray:colors];
    self.unUseColors = [NSArray arrayWithArray:colors];
}


//通过colorIdentifier 删除掉已经被使用过的颜色
- (void)colorUsed:(NSString *)colorIdentifer
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:_unUseColors];
    
    for ( UIColor *color in array ){
        if ( [color.hexString isEqualToString:colorIdentifer] ){
            [array removeObject:color];
            break;
        }
    }
    _unUseColors = [NSArray arrayWithArray:array];
    
    NSLog(@"cout: --- %d %@",(int)_unUseColors.count, colorIdentifer);
    
}


//创建一些默认的类型，这些类型不能不能被删除掉
- (NSArray *)createDefaultType
{
    //学习 红色
    EventTypeModle *learnModel = [[EventTypeModle alloc] initWithIdentifier:@"#ff0000" title:@"学习" isDefault:YES];
    [learnModel insertSQL];
    
    //工作 紫色
    EventTypeModle *workModel = [[EventTypeModle alloc] initWithIdentifier:@"#7f007f" title:@"工作" isDefault:YES];
    [workModel insertSQL];
    
    return [NSArray arrayWithObjects:learnModel,workModel, nil];
    
    
}


- (void)insertEventModle:(EventTypeModle *)model
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:_eventTypes];
    [array insertObject:model atIndex:0];
    [self colorUsed:model.identifier];
    _eventTypes = [NSArray arrayWithArray:array];
}
@end
