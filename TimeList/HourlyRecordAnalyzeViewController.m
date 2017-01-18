//
//  HourlyRecordAnalyzeViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/18.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordAnalyzeViewController.h"
#import "ClockPieChartView.h"
#import "Constants.h"
#include "HourlyRecordModel.h"

@interface HourlyRecordAnalyzeViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation HourlyRecordAnalyzeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ClockPieChartView *view = [ClockPieChartView creatWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, 400) hourlyRecordData:[HourlyRecordDataSource createWithDate:[NSDate date]]];
    [self.contentView addSubview:view];
}

@end
