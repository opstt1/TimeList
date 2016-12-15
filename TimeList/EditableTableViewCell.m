//
//  EditableTableViewCell.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/14.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "EditableTableViewCell.h"
#import "Constants.h"
#import "Toolkit.h"

#define OPSSideslipCellLeftLimitScrollMargin 5
#define OPSSideslipCellRightLimitScrollMargin 75

@interface EditableTableViewCell()


@property (nonatomic, readwrite, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, readwrite, strong) UIButton *cancelButton;
@property (nonatomic, readwrite, copy) NSArray *rightButtons;

@end

@implementation EditableTableViewCell

- (void)setCanEditableWithView:(UIView *)containView
{
    self.containView = containView;
    self.cancelButton = [UIButton new];
    [self.cancelButton addTarget:self action:@selector(cancelButtonTap:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButtons = [NSArray array];
    self.editable = YES;
}

- (void)addButton:(UIButton *)button isLeft:(BOOL)isLeft
{
    if ( !isLeft ){
        NSMutableArray *array = [NSMutableArray arrayWithArray:_rightButtons];
        [array addObject:button];
        _rightButtons = [NSArray arrayWithArray:array];
    }
}

- (void)setEditable:(BOOL)editable
{
    _editable = editable;
    if ( editable ){
        [self p_addPanGestureRecognizer];
    }
}

- (void)p_addPanGestureRecognizer
{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(containViewPan:)];
    _panGesture.delegate = self;
    [_containView addGestureRecognizer:_panGesture];
}

- (void)containViewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    [pan setTranslation:CGPointZero inView:pan.view];
    CGRect frame = _containView.frame;
    frame.origin.x += point.x;
    if ( pan.state == UIGestureRecognizerStateChanged ){
        if ( frame.origin.x > OPSSideslipCellLeftLimitScrollMargin ){
            frame.origin.x = OPSSideslipCellLeftLimitScrollMargin;
        }
        if( frame.origin.x < -OPSSideslipCellRightLimitScrollMargin){
            frame.origin.x = -OPSSideslipCellRightLimitScrollMargin;
        }
        
        _containView.frame = frame;
    }
    if ( pan.state == UIGestureRecognizerStateEnded ){
        if ( frame.origin.x < OPSSideslipCellLeftLimitScrollMargin && frame.origin.x > 5 ){
            frame.origin.x = OPSSideslipCellLeftLimitScrollMargin;
        }
        
        if ( frame.origin.x < 0 ){
            frame.origin.x = -OPSSideslipCellRightLimitScrollMargin;
        }
        [self containViewAnimationWithFrame:frame];
        [self prohibitAction];
    }
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"2333");
    
    CGRect frame = CGRectMake(5, 5, UISCREEN_WIDTH-10, 60);
    if ( ![_containView isEquelToFrame:frame] ){
        [self containViewAnimationWithFrame:frame];
        return NO;
    }
    if ( gestureRecognizer == _panGesture ){
        UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [gesture translationInView:gesture.view];
        return fabs(translation.y) <= fabs(translation.x);
    }
    return YES;
}


- (void)containViewAnimationWithFrame:(CGRect)frame;
{
    //设置速度，以后在弄
    CGFloat length = fabs(_containView.origin.x - frame.origin.x);
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _containView.frame = frame;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        _containView.frame = frame;
    }];
    
    
    
}

- (void)prohibitAction
{
    for ( UIView *next = [self superview]; next; next = next.superview ){
        UIResponder *nextResponder = [next nextResponder];
        if ( [nextResponder isKindOfClass:[UIViewController class]] ){
            _cancelButton.frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT);
            UIViewController *vc = (UIViewController *)nextResponder;
            [vc.view addSubview:_cancelButton];
            break;
        }
    }
}

- (void)cancelButtonTap:(id)sender forEvent:(UIEvent*)event
{
    
    UIView *button = (UIView *)sender;
    UITouch *touch = [[event touchesForView:button] anyObject];
    CGPoint location = [touch locationInView:button];
    
    if ( _containView.x < 0 ){
        
        [_rightButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = (UIButton *)obj;
                        CGRect rect  = [_cancelButton convertRect:button.frame fromView:self];
            if ( [button pointIsInSelf:location rect:rect] ){
                [button sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }];
    }
    
    [_cancelButton removeFromSuperview];
    _cancelButton.frame = CGRectMake(0, 0, 0, 0);
    
    [self containViewAnimationWithFrame:CGRectMake(5, 5, UISCREEN_WIDTH-10, 60)];
}


@end
