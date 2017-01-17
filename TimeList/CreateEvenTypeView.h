//
//  CreateEvenTypeView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/13.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@class EventTypeModel;

typedef void(^CreateEvenTypeViewBlock)(EventTypeModel *model);

@interface CreateEvenTypeView : BaseView

@property (nonatomic, readwrite, copy) CreateEvenTypeViewBlock complete;

+ (CreateEvenTypeView *)createWithComplete:(CreateEvenTypeViewBlock)complete;

@end
