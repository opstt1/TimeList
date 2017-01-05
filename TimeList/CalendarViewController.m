//
//  CalendarViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/3.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "CalendarViewController.h"
#import "FSCalendar.h"
#import "Constants.h"
#import "DailyRecordViewController.h"

@interface CalendarViewController ()<FSCalendarDelegate,FSCalendarDataSource>

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, 250)];
    calendar.dataSource = self;
    calendar.delegate = self;
//    calendar.appearance.headerDateFormat = @"yyyy年MM月";
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    calendar.scope = FSCalendarScopeMonth;
    calendar.scopeGesture.enabled = YES;
    [self.view addSubview:calendar];
}


- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSString *string = [NSDate stringFromDay:date];
    NSLog(@"date::  %@",string);
    NSString *begin = [NSDate stringFromDay:[date beginningOfDay]];
    NSString *end = [NSDate stringFromDay:[date endOfDay]];
    NSLog(@"\nbegin   %@  \nend:   %@",begin,end);
    
    DailyRecordViewController *vc = [[UIStoryboard storyboardWithName:@"Calendar" bundle:nil] instantiateViewControllerWithIdentifier:@"DailyRecordViewController"];
    [vc initWithDate:date];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}

@end
