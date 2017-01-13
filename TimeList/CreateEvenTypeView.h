//
//  CreateEvenTypeView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/13.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@class EventTypeModle;

typedef void(^CreateEvenTypeViewBlock)(EventTypeModle *model);

@interface CreateEvenTypeView : BaseView

@property (nonatomic, readwrite, copy) CreateEvenTypeViewBlock complete;

+ (CreateEvenTypeView *)createWithComplete:(CreateEvenTypeViewBlock)complete;

@end
