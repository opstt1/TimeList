//
//  ThirdViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/3.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "ThirdViewController.h"
#import "EventTypeListViewController.h"
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
- (IBAction)didTapEventTypeButton:(id)sender
{
    EventTypeListViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EventTypeListViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
