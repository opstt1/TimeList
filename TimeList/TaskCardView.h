//
//  TaskCardView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/3/3.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

typedef NS_ENUM(NSInteger, TaskCardMoveDirection)
{
    TaskCardMoveUp,
    TaskCardMoveRight,
    TaskCardMoveDowm,
    TaskCardMoveLeft
};

typedef NS_ENUM(NSInteger, TaskCardStatusDirection)
{
    TaskCardInTheUp,
    TaskCardInTheRight,
    TaskCardInTheDowm,
    TaskCardInTheLeft
};
@interface TaskCardView : BaseView

@property (nonatomic, readonly, assign) TaskCardMoveDirection cardDirection;

@end
