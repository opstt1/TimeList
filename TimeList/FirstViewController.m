//
//  FirstViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "FirstViewController.h"
#import "TaskListTableViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRightNavigationButtonWithTitle:@"2333" tintColor:[UIColor blackColor]];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Task" bundle:nil];
    
    TaskListTableViewController *vC = [storyboard instantiateViewControllerWithIdentifier:@"TastListTableViewController"];
    [vC willMoveToParentViewController:self];
    [self.view insertSubview:vC.view aboveSubview:self.view];
    [self addChildViewController:vC];
    [vC didMoveToParentViewController:self];
    [self layoutViewContrller:vC];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
- (void)layoutViewContrller:(UIViewController *)pageController
{
    UIView *pageView = pageController.view;
    if ( [pageView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        pageView.preservesSuperviewLayoutMargins = YES;
    }
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
}

@end
