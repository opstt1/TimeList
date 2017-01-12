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
    
    [EventTypeModle createSqliteTable];
    _eventTypes = [EventTypeModle findAll];
    if ( _eventTypes.count <=0 ){
        _eventTypes = [self createDefaultType];
    }
    
    for ( EventTypeModle *model in _eventTypes ){
        [self colorUsed:model.identifier];
//        [model removeSQL];
    }
    
    return self;
}


- (void)initColos
{
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:color(0x0000FF),color(0x996633),color(0x00FFFF),color(0x00FF00),color(0xFF00FF),color(0xFF7F00),color(0x7F007F),color(0xFF0000),color(0xFFFF00), nil];

    self.colors = [NSArray arrayWithArray:colors];
    self.unUseColors = [NSArray arrayWithArray:colors];
}


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

@end
