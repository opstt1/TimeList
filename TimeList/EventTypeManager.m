//
//  EventTypeManager.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeManager.h"
#import "Constants.h"
#import "EventTypeModel+FMDB.h"

#define color(x) [UIColor colorWithRGB:x]

@interface EventTypeManager()

@property (nonatomic, readwrite, copy) NSArray *colors;
@property (nonatomic, readwrite, copy) NSArray *unUseColors;

@end

@implementation EventTypeManager

+ (instancetype)shareManager
{
    static EventTypeManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EventTypeManager alloc] init];
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
    [EventTypeModel createSqliteTable];
    [self dataSourceWithArray:[EventTypeModel findAll]];
    
    if ( [self count] <=0 ){
        //如果数据库中没有数据，那就是第一次加载，创建出默认的类型
        [self dataSourceWithArray:[self createDefaultType]];
    }
    
    [self changeUnUsedColors];
    
    return self;
}

//初始化颜色数组
- (void)initColos
{
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:color(0x0000FF),color(0x996633),color(0x00FFFF),color(0x00FF00),color(0xFF00FF),color(0xFF7F00),color(0x7F007F),color(0xFF0000),color(0xFFFF00), nil];

    _colors = [NSArray arrayWithArray:colors];
    _unUseColors = [NSArray arrayWithArray:colors];
}


- (void)changeUnUsedColors
{
    _unUseColors = [NSArray arrayWithArray:_colors];
    for ( EventTypeModel *model in [self dataList] ){
        [self colorUsed:model.identifier];
    }
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
    EventTypeModel *learnModel = [[EventTypeModel alloc] initWithIdentifier:@"#ff0000" title:@"学习" isDefault:YES];
    [learnModel insertSQL];
    
    //工作 紫色
    EventTypeModel *workModel = [[EventTypeModel alloc] initWithIdentifier:@"#7f007f" title:@"工作" isDefault:YES];
    [workModel insertSQL];
    
    return [NSArray arrayWithObjects:learnModel,workModel, nil];
    
}


#pragma mark - interface

- (id)deleteAtIndex:(NSInteger)index
{
    EventTypeModel *model = [super deleteAtIndex:index];
    [model removeSQL];
    [self changeUnUsedColors];
    return nil;
}

- (void)insertmodel:(id)model
{
    [self colorUsed:((EventTypeModel *)model).identifier];
    [super insertmodel:model];
    
}


@end
