//
//  RectAnimationTransitionPop.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/10.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "RectAnimationTransitionPop.h"
#import "BaseViewController.h"
#import "Constants.h"

@interface RectAnimationTransitionPop()<CAAnimationDelegate>

@property(nonatomic, readwrite, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property(nonatomic, readwrite, strong) BaseViewController *toViewController;

@end

@implementation RectAnimationTransitionPop

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    BaseViewController *fromVC = (BaseViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BaseViewController *toVC = (BaseViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _toViewController = toVC;
    
    [toVC.tabBarController.tabBar setHidden:YES];
    UIView *contView = [transitionContext containerView];
    
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:toVC.selectRect];
   
    [contView addSubview:toVC.view];
    [contView addSubview:fromVC.view];
    
    contView.backgroundColor = [UIColor orangeColor];
    
    CGPoint dCenter = CGPointMake(toVC.selectRect.origin.x+toVC.selectRect.size.width/2, toVC.selectRect.origin.y+toVC.selectRect.size.height/2);
    CGFloat radius = (UISCREEN_WIDTH-dCenter.x) > dCenter.x ? (UISCREEN_WIDTH-dCenter.x) : dCenter.x;
    CGFloat dy = (UISCREEN_HEIGHT-dCenter.y) > dCenter.y ? (UISCREEN_HEIGHT-dCenter.y) : dCenter.y;
    radius = radius > dy ? radius : dy;
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(toVC.selectRect, -radius, -radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    fromVC.view.layer.mask = maskLayer;
    
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"pingInvert"];
    
}

#pragma mark - CABasicAnimation的Delegate


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    
    //    清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}



@end
