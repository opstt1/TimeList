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


#define OPSSideslipCellRightLimitScrollMargin 75

@interface EditableTableViewCell()


@property (nonatomic, readwrite, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, readwrite, strong) UIButton *cancelButton;
@property (nonatomic, readwrite, assign) CGRect contentFrame;

@end

@implementation EditableTableViewCell

- (void)setCanEditableWithView:(UIView *)containView
{
    self.containView = containView;
    self.cancelButton = [UIButton new];
    [self.cancelButton addTarget:self action:@selector(cancelButtonTap:forEvent:) forControlEvents:UIControlEventTouchDown];
    self.rightButtons = [NSArray array];
    self.leftButtons = [NSArray array];
    _sideslipLeftLimitMargin = 5.0f;
    _sideslipRightLimitMargin = 5.0f;
    _sideslipCellLimitScrollMargin = 5.0f;
    self.editable = YES;
}

#pragma mark - set

- (void)setEditable:(BOOL)editable
{
    _editable = editable;
    if ( editable ){
        [self p_addPanGestureRecognizer];
    }
}

- (void)setSideslipLeftLimitMargin:(CGFloat)sideslipLeftLimitMargin
{
    _sideslipLeftLimitMargin = _sideslipCellLimitScrollMargin + sideslipLeftLimitMargin;
}

- (void)setSideslipRightLimitMargin:(CGFloat)sideslipRightLimitMargin
{
    _sideslipRightLimitMargin = _sideslipCellLimitScrollMargin - sideslipRightLimitMargin;
}

#pragma  mark - add 

- (void)p_addPanGestureRecognizer
{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(containViewPan:)];
    _panGesture.delegate = self;
    [_containView addGestureRecognizer:_panGesture];
}

- (void)addButton:(UIButton *)button isLeft:(BOOL)isLeft
{
    if ( !isLeft ){
        NSMutableArray *array = [NSMutableArray arrayWithArray:_rightButtons];
        [array addObject:button];
        _rightButtons = [NSArray arrayWithArray:array];
    }else{
        NSMutableArray *array = [NSMutableArray arrayWithArray:_leftButtons];
        [array addObject:button];
        _leftButtons = [NSArray arrayWithArray:array];
    }
}


#pragma mark - touch action

//监听手势同时更改位置
- (void)containViewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    [pan setTranslation:CGPointZero inView:pan.view];
    CGRect frame = _containView.frame;
    frame.origin.x += point.x;
    if ( pan.state == UIGestureRecognizerStateChanged ){
        if ( frame.origin.x > _sideslipLeftLimitMargin ){
            frame.origin.x = _sideslipLeftLimitMargin;
        }
        if( frame.origin.x < _sideslipRightLimitMargin){
            frame.origin.x = _sideslipRightLimitMargin;
        }
        
        _containView.frame = frame;
    }
    if ( pan.state == UIGestureRecognizerStateEnded ){
        if ( frame.origin.x < _sideslipLeftLimitMargin && frame.origin.x > _sideslipCellLimitScrollMargin ){
            frame.origin.x = _sideslipLeftLimitMargin;
        }
        
        if ( frame.origin.x < _sideslipCellLimitScrollMargin ){
            frame.origin.x = _sideslipRightLimitMargin;
        }
        [self containViewAnimationWithFrame:frame];
        if ( frame.origin.x > _sideslipCellLimitScrollMargin + 1.0f || frame.origin.x < _sideslipCellLimitScrollMargin - 1.0f ){
            [self prohibitAction];
        }
    }
    
}

//手势开始时
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer != _panGesture ){
        return YES;
    }
    
    _contentFrame = _containView.frame;
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint translation = [gesture translationInView:gesture.view];
    
    if ( !_canSlideToLeft && translation.x < 0  ){
        return NO;
    }
    return fabs(translation.y) <= fabs(translation.x);

}


//禁止所有无关手势操作，处于可编辑状态
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

//取消可编辑状态，识别触发了哪一个事件
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
    
    if ( _containView.x > 0 ){
        [_leftButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = (UIButton *)obj;
            CGRect rect  = [_cancelButton convertRect:button.frame fromView:self];
            if ( [button pointIsInSelf:location rect:rect] ){
                [button sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }];
    }

    [_cancelButton removeFromSuperview];
    _cancelButton.frame = CGRectMake(0, 0, 0, 0);
    
    [self containViewAnimationWithFrame:_contentFrame];
}

#pragma mark - animation

//是否可编辑状态动画
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


#pragma mark -

- (void)configWithData:(id)data indexPath:(NSIndexPath *)indexPath delegateTarget:(id)delegateTarget
{
    return;
}

- (void)configWithData:(id)data deleteBlock:(EditableCellDeleteBlock)deleteBlock editBlock:(EditableCellEditBlock)editBlock
{
    return;
}
@end
