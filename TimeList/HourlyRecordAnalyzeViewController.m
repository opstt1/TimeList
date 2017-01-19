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
#import "HourlyRecordModel.h"
#import "EventTpyeShowView.h"
#import "HourlyRecordEventTypeShowView.h"

@interface HourlyRecordAnalyzeViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@end

@implementation HourlyRecordAnalyzeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    HourlyRecordDataSource *dataSource = [HourlyRecordDataSource createWithDate:[NSDate date]];
    
    ClockPieChartView *view = [ClockPieChartView creatWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_WIDTH) hourlyRecordData:dataSource];
    [self.contentView addSubview:view];
    
    
    EventTpyeShowView *eventTypeShowView = [EventTpyeShowView createWithData:dataSource];
    
    eventTypeShowView.frame = CGRectMake(0, view.y + view.height + 20, UISCREEN_WIDTH, eventTypeShowView.height);
    [self.contentView addSubview:eventTypeShowView];
    
    HourlyRecordEventTypeShowView *hourlyRecordEventTypeShowView = [HourlyRecordEventTypeShowView creatWithFrame:CGRectMake(0, eventTypeShowView.y + eventTypeShowView.height - UISCREEN_WIDTH/8 + 50, UISCREEN_WIDTH, UISCREEN_WIDTH) hourlyRecordData:dataSource];
    
    [self.contentView addSubview:hourlyRecordEventTypeShowView];
    
    _contentViewHeight.constant = hourlyRecordEventTypeShowView.y + hourlyRecordEventTypeShowView.height + 10;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0.0f;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 1.0f;
}

@end
