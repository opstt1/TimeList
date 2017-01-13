//
//  TaskDetailPushAnimatedTransitioning.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/9.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "TaskDetailPushAnimatedTransitioning.h"
#import "TaskDetailViewController.h"
#import "FirstViewController.h"
#import "Constants.h"
#import <CoreFoundation/CoreFoundation.h>

@interface TaskDetailPushAnimatedTransitioning()<CAAnimationDelegate>

@property(nonatomic, readwrite, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation TaskDetailPushAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;

    BaseViewController *fromVC = (BaseViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BaseViewController *toVC = (BaseViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *contView = [transitionContext containerView];
    
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:fromVC.selectRect];
//    [contView addSubview:fromVC.view];
    [contView addSubview:toVC.view];
    contView.backgroundColor = [UIColor orangeColor];
    
    
    CGFloat radius = UISCREEN_HEIGHT + 100;
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(fromVC.selectRect, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    maskLayer.backgroundColor = [UIColor redColor].CGColor;
    maskLayer.borderColor = [UIColor redColor].CGColor;
    maskLayer.borderWidth = 2.0f;
    toVC.view.layer.mask = maskLayer;
    
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

#pragma mark - CABasicAnimation的Delegate


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:YES];
//    清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}


@end