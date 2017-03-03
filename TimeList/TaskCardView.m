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

@property (nonatomic, readwrite, assign) CGPoint currentCenter;

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
    self.layer.borderWidth = 1.5f;
    _currentCenter = self.center;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"card-bg"];
    imageView.frame = CGRectMake(0, 0, self.width, self.height);
    imageView.layer.cornerRadius = self.layer.cornerRadius;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panGesture];
    
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
    self.centerX = _currentCenter.x + dictionx;
    self.centerY = _currentCenter.y + dictiony;
    
    if ( recongizer.state == UIGestureRecognizerStateEnded ){
        CGFloat centerX = self.centerX;
        CGFloat centerY = self.centerY;
        NSLog(@"end:  %lf", UISCREEN_WIDTH / 2);
        
        
        
        if ( self.centerX >= UISCREEN_WIDTH - 10.0f ){
            centerX = UISCREEN_WIDTH / 2 * 3 - 50.0f;
        }else if ( self.centerX < 0 ){
            centerX = -UISCREEN_WIDTH/2 + 50.0f;
        }else{
            centerX= UISCREEN_WIDTH / 2;
        }
        
        if ( self.centerY > UISCREEN_HEIGHT /2  ){
            
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
        
    }];
}
//手势开始时
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint translation = [gesture translationInView:gesture.view];
    
    if ( fabs(translation.y) <= fabs(translation.x) ){
        if ( translation.x > 0 ){
            _cardMoveDirection = TaskCardMoveRight;
        }else{
            _cardMoveDirection = TaskCardMoveLeft;
        }
    }else{
        if ( translation.y > 0 ){
            _cardMoveDirection = TaskCardMoveDowm;
        }else{
            _cardMoveDirection = TaskCardMoveUp;
        }
    }
    return YES;
    
}


@end
