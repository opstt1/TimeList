//
//  BaseViewController.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+AutoNavBtnSetup.h"
#import "UINavigationController+CustomAnimation.h"

typedef void(^BaseViewControllerBlock)(id result);

@interface BaseViewController : UIViewController

@property (nonatomic, readwrite, assign) CGRect selectRect;
@property (nonatomic, readwrite, strong) id<UIViewControllerAnimatedTransitioning> pushAnimationTransition;
@property (nonatomic, readwrite, strong) id<UIViewControllerAnimatedTransitioning>popAnimationTransition;
@property (nonatomic, readwrite, assign) BOOL useCustomAnimation;

@property (nonatomic, readwrite, copy) BaseViewControllerBlock bvcBlock;


- (void)updateViewController;

- (void)addBackGestureRecognizer;

- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated useCustomAnimation:(BOOL)useCustomAnimation;

- (void)popViewControllerAnimated:(BOOL)animated useCustomAnimation:(BOOL)useCustomAnimation;
@end
