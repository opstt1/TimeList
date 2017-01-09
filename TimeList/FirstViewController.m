//
//  FirstViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "FirstViewController.h"
#import "TaskListTableViewController.h"
#import "TaskListSessionManager.h"
#import "TaskDetailViewController.h"
#import "Constants.h"
#import "TaskDataSource+Func.h"
#import "TaskDetailPushAnimatedTransitioning.h"

@interface FirstViewController ()<UINavigationControllerDelegate>

@property (nonatomic, readwrite, strong) TaskListTableViewController *currentVC;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRightNavigationButtonWithTitle:@"排序" tintColor:[UIColor blackColor]];
    [self setUpLeftNavigationButtonWithTitle:@"+" tintColor:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Task" bundle:nil];
    
    TaskListTableViewController *vC = [storyboard instantiateViewControllerWithIdentifier:@"TastListTableViewController"];
    [vC configWithData:[[TaskListSessionManager sharedManager] dataSource] dailySummaryDataSource:[[TaskListSessionManager sharedManager] dailySummaryDataSource]];
    [vC willMoveToParentViewController:self];
    [self.view insertSubview:vC.view aboveSubview:self.view];
    [self addChildViewController:vC];
    [vC didMoveToParentViewController:self];
    [self layoutViewContrller:vC];
    _currentVC = vC;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate=self;
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


- (void)rightNavigationButtonTapped:(id)sender
{
    [[[TaskListSessionManager sharedManager] dataSource] sortDefault];
}
#pragma mark - action

- (void)leftNavigationButtonTapped:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Task" bundle:nil];
    
    TaskDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    WEAK_OBJ_REF(self);
    [vc createComplete:^(TaskModel *model) {
        STRONG_OBJ_REF(weak_self);
        if ( strong_weak_self ){
            [model createSuccess];
            [(TaskDataSource *)[[TaskListSessionManager sharedManager] dataSource] insertModel:model];
        }
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ( operation == UINavigationControllerOperationPush ){
        TaskDetailPushAnimatedTransitioning *push = [TaskDetailPushAnimatedTransitioning new];
        return push;
    }else{
        return nil;
    }
}

@end
