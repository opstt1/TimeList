//
//  EventTypeModle.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDBManager.h"
                                   
@interface EventTypeModle : NSObject

//颜色的id
@property (nonatomic, readwrite, copy) NSString *identifier;

//分类的标题
@property (nonatomic, readwrite, copy) NSString *title;

//是否是默认类型，如果是，不能删除
@property (nonatomic, readwrite, assign) BOOL isDefault;


@property (nonatomic, readonly, strong) UIColor *color;


- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title isDefault:(BOOL)isDefault;

@end
