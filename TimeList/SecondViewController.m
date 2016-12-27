//
//  SecondViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "SecondViewController.h"
#import "HourlyRecordCreateView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLeftNavigationButtonWithTitle:@"+" tintColor:nil];
}


- (void)leftNavigationButtonTapped:(id)sender
{
    HourlyRecordCreateView *view = [HourlyRecordCreateView create];
}
@end
