//
//  ThirdViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/3.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}


- (IBAction)didTapButton:(id)sender
{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Calendar" bundle:nil] instantiateViewControllerWithIdentifier:@"CalendarViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
