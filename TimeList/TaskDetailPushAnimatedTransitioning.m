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

@interface TaskDetailPushAnimatedTransitioning()

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
    FirstViewController *fromVC = (FirstViewController *)[transitionContext viewForKey:UITransitionContextFromViewControllerKey];
    TaskDetailViewController *toVC = (TaskDetailViewController *)[transitionContext viewForKey:UITransitionContextToViewControllerKey];
    
    UIView *contView = [transitionContext containerView];
    
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(contView.frame.size.width/2, contView.frame.size.height/2, 10, 10)];
    [contView addSubview:fromVC.view];
    [contView addSubview:toVC.view];
    
    CGPoint finalPoint = CGPointMake(contView.centerX, contView.centerY);
    
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x ) + (finalPoint.y * finalPoint.y));
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(contView.frame.size.width/2, contView.frame.size.height/2, 10, 10), -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
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
    //清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}


@end
