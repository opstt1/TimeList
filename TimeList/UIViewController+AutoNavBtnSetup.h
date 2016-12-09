//
//  UIViewController+AutoNavBtnSetup.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(AutoNavBtnSetup)


/**
 自动创建返回按钮，默认为YES

 @return 是否自动创建返回按钮
 */
- (BOOL)autoSetupBackNavigationButton;

- (void)setUpBackNavigationButtonWithImage:(UIImage *)image tintColor:(UIColor *)tintColor;

- (void)setUpLeftNavigationButtonWithImage:(UIImage *)image tintColor:(UIColor *)tintColor;
- (void)setUpLeftNavigationButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor;
- (void)setUpLeftNavigationButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor font:(UIFont *)font;

- (void)setUpRightNavigationButtonWithImage:(UIImage *)image tintColor:(UIColor *)tintColor;
- (void)setUpRightNavigationButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor;
- (void)setUpRightNavigationButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor font:(UIFont *)font;

- (IBAction)backButtonClicked:(id)sender;

- (IBAction)leftNavigationButtonTapped:(id)sender;

- (IBAction)rightNavigationButtonTapped:(id)sender;


@end
