//
//  TaskCardView.h
//  TimeList
//
//  Created by LiHaomiao on 2017/3/3.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@class TaskCardView;

@protocol TasckCardViewDelegate <NSObject>

@optional
- (void)taskCardView:(TaskCardView *)taskCardView changeCenter:(CGPoint)center;

@end

typedef NS_ENUM(NSInteger, TaskCardMoveDirection)
{
    TaskCardMoveUp,
    TaskCardMoveRight,
    TaskCardMoveDowm,
    TaskCardMoveLeft
};

typedef NS_ENUM(NSInteger, TaskCardStatusDirection)
{
    TaskCardInTheCenter,
    TaskCardInTheUp,
    TaskCardInTheRight,
    TaskCardInTheDowm,
    TaskCardInTheLeft
};
@interface TaskCardView : BaseView

@property (nonatomic, readonly, assign) TaskCardMoveDirection cardDirection;

@property (nonatomic, readwrite, weak) id<TasckCardViewDelegate> taskCardViewDelegate;

@end
