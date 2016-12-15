//
//  UINavigationController+CustomAnimation.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "UINavigationController+CustomAnimation.h"

@implementation UINavigationController (CustomAnimation)

- (void)customPushViewController:(UIViewController *)viewController
{
    viewController.view.frame = (CGRect){0, -viewController.view.frame.size.height, viewController.view.frame.size};
    [self.topViewController.view addSubview:viewController.view];
    [UIView animateWithDuration:.15f
                     animations:^{
                         viewController.view.frame = (CGRect){0, 0, self.view.bounds.size};
                     }];
}

@end
