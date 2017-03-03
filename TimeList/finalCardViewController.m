//
//  finalCardViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/3/2.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "finalCardViewController.h"

@interface finalCardViewController ()

@end

@implementation finalCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}


@end
