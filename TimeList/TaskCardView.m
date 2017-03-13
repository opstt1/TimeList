//
//  TaskCardView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/3/3.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "TaskCardView.h"
#import "Constants.h"

@interface TaskCardView()

@property (nonatomic, readwrite, assign) TaskCardMoveDirection cardMoveDirection;
@property (nonatomic, readwrite, assign) TaskCardStatusDirection cardStatusDirection;
@property (nonatomic, readwrite, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, readwrite, assign) CGPoint currentCenter;
@property (nonatomic, readwrite, assign, getter=isResponsChangeCenterDelegate) BOOL responsChangeCenterDelegate;

@end

@implementation TaskCardView

-(instancetype)init
{
    self = [super init];
    if ( !self ){
        return nil;
    }
    self.frame = CGRectMake(2, 2, UISCREEN_WIDTH-4, UISCREEN_HEIGHT-4);
    self.layer.cornerRadius = 20.0f;
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [UIColor redColor].CGColor;
    _currentCenter = self.center;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"card-bg"];
    imageView.frame = CGRectMake(0, 0, self.width, self.height);
    imageView.layer.cornerRadius = self.layer.cornerRadius;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:_panGesture];
    
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)recongizer
{
    CGFloat dictionx = 0.0f;
    CGFloat dictiony = 0.0f;
    if ( _cardMoveDirection == TaskCardMoveRight || _cardMoveDirection == TaskCardMoveLeft ){
        dictionx = [recongizer translationInView:self].x;
    }else{
        dictiony = [recongizer translationInView:self].y;
    }
    if ( _responsChangeCenterDelegate ){
        [_taskCardViewDelegate taskCardView:self changeCenter:CGPointMake(_currentCenter.x + dictionx, _currentCenter.y + dictiony)];
    }
    self.centerX = _currentCenter.x + dictionx;
    self.centerY = _currentCenter.y + dictiony;
    
    if ( recongizer.state == UIGestureRecognizerStateEnded ){
        CGFloat centerX = self.centerX;
        CGFloat centerY = self.centerY;
        if ( _cardStatusDirection != TaskCardInTheUp && _cardStatusDirection != TaskCardInTheDowm ){
            if ( self.centerX >= UISCREEN_WIDTH - 10.0f ){
                centerX = UISCREEN_WIDTH / 2 * 3 - 50.0f;
                _cardStatusDirection = TaskCardInTheRight;
            }else if ( self.centerX < 0 ){
                centerX = -UISCREEN_WIDTH/2 + 50.0f;
                _cardStatusDirection = TaskCardInTheLeft;
            }else{
                centerX= UISCREEN_WIDTH / 2;
                _cardStatusDirection = TaskCardInTheCenter;
            }
        }
    
        if ( _cardStatusDirection != TaskCardInTheLeft && _cardStatusDirection != TaskCardInTheRight ){
            if ( self.centerY > UISCREEN_HEIGHT /2 + 50.0f && _cardMoveDirection == TaskCardMoveDowm ){
                centerY = UISCREEN_HEIGHT / 2 * 3 - 100.0f;
                _cardStatusDirection = TaskCardInTheDowm;
            }else if ( self.centerY < UISCREEN_HEIGHT / 2 - 50.0f && _cardMoveDirection == TaskCardMoveUp ){
                centerY = - (UISCREEN_HEIGHT / 2) + 100.0f;
                _cardStatusDirection = TaskCardInTheUp;
            }else{
                centerY = UISCREEN_HEIGHT / 2;
                _cardStatusDirection = TaskCardInTheCenter;
            }
        }
    
        if ( _responsChangeCenterDelegate && _cardStatusDirection != TaskCardInTheCenter ){
            [_taskCardViewDelegate taskCardView:self changeCenter:CGPointMake(centerX, centerY)];
        }
        
        [self moveAnimationWithCenterX:centerX centerY:centerY];
        _currentCenter = self.center;
    }
}

- (void)moveAnimationWithCenterX:(CGFloat)centerX centerY:(CGFloat)centerY
{
    [UIView animateWithDuration:0.5 animations:^{
        self.centerX = centerX;
        self.centerY = centerY;
    } completion:^(BOOL finished) {
        if ( finished && _responsChangeCenterDelegate && _cardStatusDirection == TaskCardInTheCenter ){
            [_taskCardViewDelegate taskCardView:self changeCenter:CGPointMake(centerX, centerY)];
        }
    }];
}
//手势开始时
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer != _panGesture ){
        return NO;
    }
    if ( !_responsChangeCenterDelegate ){
        if ( _taskCardViewDelegate && [_taskCardViewDelegate respondsToSelector:@selector(taskCardView:changeCenter:)] ){
            _responsChangeCenterDelegate = YES;
        }else{
            _responsChangeCenterDelegate = NO;
        }
    }
    
    
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint translation = [gesture translationInView:gesture.view];
    
    if ( fabs(translation.y) <= fabs(translation.x)  ){
        if ( translation.x > 0 ){
            _cardMoveDirection = TaskCardMoveRight;
        }else{
            _cardMoveDirection = TaskCardMoveLeft;
        }
        if ( _cardStatusDirection == TaskCardInTheUp || _cardStatusDirection == TaskCardInTheDowm ){
            return NO;
        }
    }else{
        if ( translation.y > 0 ){
            _cardMoveDirection = TaskCardMoveDowm;
        }else{
            _cardMoveDirection = TaskCardMoveUp;
        }
        if ( _cardStatusDirection == TaskCardInTheRight || _cardStatusDirection == TaskCardInTheLeft ){
            return NO;
        }
    }
    return YES;
    
}


@end
