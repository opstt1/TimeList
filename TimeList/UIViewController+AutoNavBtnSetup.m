//
//  UIViewController+AutoNavBtnSetup.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "UIViewController+AutoNavBtnSetup.h"
#import "UIColor+TAToolkit.h"

@implementation UIViewController (AutoNavBtnSetup)

- (BOOL)autoSetupBackNavigationButton
{
    return YES;
}

- (void)setUpBackNavigationButtonWithImage:(UIImage *)image tintColor:(UIColor *)tintColor
{
    UIImage *navImage = image ?: [UIImage imageNamed:@"nav-btn-back"];
    UIColor *color = tintColor ?: [UIColor colorWithRGB:0xffffff];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:navImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked:)];
    barItem.tintColor = color;
    self.navigationItem.leftBarButtonItem = barItem;
}

#pragma mark - leftNavigation

- (void)setUpLeftNavigationButtonWithImage:(UIImage *)image tintColor:(UIColor *)tintColor
{
    [self p_setNavigationButtonWithIsLeft:YES image:image tintColor:tintColor];
}

- (void)setUpLeftNavigationButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor
{
    [self setUpLeftNavigationButtonWithTitle:title tintColor:tintColor font:[UIFont systemFontOfSize:16.0f]];
}

- (void)setUpLeftNavigationButtonWithTitle:(NSString *)title tintColor:(UIColor *)tintColor font:(UIFont *)font
{
    [self p_setNavigationButtonWithIsLeft:YES title:title tintColor:tintColor font:font];
}


#pragma mark - rightNavigation

- (void)setUpRightNavigationButtonWithImage:(UIImage *)image
                                  tintColor:(UIColor *)tintColor
{
    [self p_setNavigationButtonWithIsLeft:NO
                                    image:image
                                tintColor:tintColor];
}

- (void)setUpRightNavigationButtonWithTitle:(NSString *)title
                                  tintColor:(UIColor *)tintColor
{
    [self setUpRightNavigationButtonWithTitle:title
                                    tintColor:tintColor
                                         font:nil];
}

- (void)setUpRightNavigationButtonWithTitle:(NSString *)title
                                  tintColor:(UIColor *)tintColor
                                       font:(UIFont *)font
{
    [self p_setNavigationButtonWithIsLeft:NO
                                    title:title
                                tintColor:tintColor
                                     font:font];
}

#pragma mark - Navigation

- (void)p_setNavigationButtonWithIsLeft:(BOOL)isLeft
                                  title:(NSString *)title
                              tintColor:(UIColor *)tintColor
                                   font:(UIFont *)font
{
    if ( !title ){
        title = @"";
    }
    if ( !tintColor ){
        tintColor = [UIColor blackColor];
    }
    if ( !font ){
        font = [UIFont systemFontOfSize:16.0f];
    }
    UIBarButtonItem *baritem;
    
    if ( isLeft ){
        baritem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftNavigationButtonTapped:)];
    }else{
        baritem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationButtonTapped:)];
    }
    baritem.tintColor = tintColor;
    [baritem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self p_setNavigationItemButton:baritem isLeft:isLeft];
}

- (void)p_setNavigationButtonWithIsLeft:(BOOL)isLeft
                                  image:(UIImage *)image
                              tintColor:(UIColor *)tintColor
{
    if ( !tintColor ){
        tintColor = [UIColor blackColor];
    }
    if ( !image ){
        image = [UIImage new];
    }
    
    UIBarButtonItem *baritem;
    if ( isLeft ){
        baritem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftNavigationButtonTapped:)];
    }else{
        baritem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationButtonTapped:)];
    }
    
    baritem.tintColor = tintColor;
    [self p_setNavigationItemButton:baritem isLeft:isLeft];
}

- (void)p_setNavigationItemButton:(UIBarButtonItem *)navigationButton
                           isLeft:(BOOL)isLeft
{
    if ( isLeft ){
        self.navigationItem.leftBarButtonItem = navigationButton;;
    }else {
        self.navigationItem.rightBarButtonItem = navigationButton;
    }
}

#pragma mark - action

- (IBAction)backButtonClicked:(id)sender
{
    
}

- (IBAction)leftNavigationButtonTapped:(id)sender;
{
    
}

- (IBAction)rightNavigationButtonTapped:(id)sender;
{
    
}

@end
