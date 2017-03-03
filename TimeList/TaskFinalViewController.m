//
//  TaskFinalViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/3/3.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "TaskFinalViewController.h"
#import "TaskCardView.h"

@interface TaskFinalViewController ()

@end

@implementation TaskFinalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TaskCardView *cardView = [[TaskCardView alloc] init];
    [self.view addSubview:cardView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.backgroundColor = [UIColor blueColor];
    barImageView.alpha = 0.0f;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 1.0f;
}




@end
