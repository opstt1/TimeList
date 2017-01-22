//
//  DailyRecordViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/4.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "DailyRecordViewController.h"
#import "Constants.h"
#import "TaskDataSource+Sort.h"
#import "DailyTaskRecordView.h"
#import "HourlyRecordModel.h"
#import "HourlyRecordView.h"
#import "HourlyRecordAnalyzeViewController.h"
#import "FSCalendar.h"

@interface DailyRecordViewController ()<FSCalendarDelegate,FSCalendarDataSource>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (nonatomic, readwrite, assign) CGFloat pointY;
@property (nonatomic, readwrite, strong) UIView *taskView;
@property (nonatomic, readwrite, strong) UIView *timeRecordView;

@property (nonatomic, readwrite, strong) TaskDataSource *taskDataSource;
@property (nonatomic, readwrite, strong) HourlyRecordDataSource *hourlyDataSource;
@property (nonatomic, readwrite, strong) NSDate *date;

@end

@implementation DailyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCalendarView];
    
}

#pragma mark - set

- (void)setDate:(NSDate *)date
{
    _date = date;
    _pointY = 10.0f;
    self.taskDataSource = [TaskDataSource creatTaksDataWithDate:date];
    [self.taskDataSource sortWithFirstKeyImptanceFromeHeight:YES];
    
    self.hourlyDataSource = [HourlyRecordDataSource createWithDate:date];
    [self.hourlyDataSource sortStartDateIsAscending:YES];
    
    self.title = [NSDate stringFromDay:date formatStr:@"yyyy年MM月dd日"];

}
#pragma mark - init 

- (void)initCalendarView
{
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, 250)];
    calendar.dataSource = self;
    calendar.delegate = self;
    [calendar selectDate:_date scrollToDate:YES];
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    calendar.scope = FSCalendarScopeMonth;
    calendar.scopeGesture.enabled = NO;
    [self.view addSubview:calendar];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [calendar setScope:FSCalendarScopeWeek animated:YES];
    });
}

- (void)initWithDate:(NSDate *)date
{
    if ( !date ){
        date = [NSDate date];
    }
    self.date = date;
}

- (void)initView
{
    [self initTaskView];
    [self initHourlyRecordView];
}

- (void)reloadViewWithDate:(NSDate *)date
{
    self.date = date;
    [self initView];
}

- (void)initTaskView
{
    UILabel *taskTitleLabel = [self creatTitleLabelWithTitle:@"任务记录"];
    taskTitleLabel.frame = CGRectMake(0, _pointY, UISCREEN_WIDTH, 16);
    [self.contentView addSubview:taskTitleLabel];
    
    _pointY += 10 + taskTitleLabel.height;
    
    for ( TaskModel *taskModel in self.taskDataSource.taskList ){
        DailyTaskRecordView *taskView = [DailyTaskRecordView createWithTaskModel:taskModel];
        taskView.frame = CGRectMake(0, _pointY, UISCREEN_WIDTH, taskView.viewHeight);
        [self.contentView addSubview:taskView];
        taskView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _pointY += taskView.viewHeight + 5.0f;
    }
    _pointY += 10.0f;
    _contentViewHeight.constant = _pointY;
}

- (void)initHourlyRecordView
{
    _pointY += 20.0f;
    
    UILabel *hourlyRecordLabel = [self creatTitleLabelWithTitle:@"时间记录"];
    hourlyRecordLabel.frame = CGRectMake(0, _pointY, UISCREEN_WIDTH, 16);
    [self.contentView addSubview:hourlyRecordLabel];
    
    //添加参看时间记录统计按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH - 100, _pointY, 100, 16)];
    [button setTitle:@"数据统计 ->" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [button addTarget:self action:@selector(didTapTimeRecordAnalyze:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    
    _pointY += 10 + hourlyRecordLabel.height;
    
    
    for ( int i = 0; i < _hourlyDataSource.count; ++i ){
        HourlyRecordModel *model = [_hourlyDataSource objectAtInde:i];
        
        if ( i != 0 ){
            HourlyRecordModel *preModel = [_hourlyDataSource objectAtInde:i-1];
            if ( ![preModel.endDate isSameMinute:model.startDate] ){
                HourlyRecordView *view = [HourlyRecordView createWithDate:preModel.endDate content:@"---"];
                view.frame = CGRectMake(0, _pointY, UISCREEN_WIDTH, view.viewHeight);
                [self.contentView addSubview:view];
                _pointY += view.viewHeight;
            }
        }
        
        HourlyRecordView *view = [HourlyRecordView createWithDate:model.startDate content:model.content];
        view.frame = CGRectMake(0, _pointY, UISCREEN_WIDTH, view.viewHeight);
        [self.contentView addSubview:view];
        _pointY += view.viewHeight;
        
        if ( i == _hourlyDataSource.count - 1 ){
            HourlyRecordView *view = [HourlyRecordView createWithDate:model.endDate content:@"end"];
            view.frame = CGRectMake(0, _pointY, UISCREEN_WIDTH, view.viewHeight);
            [self.contentView addSubview:view];
            _pointY += view.viewHeight;

        }
    }
    
    _contentViewHeight.constant = _pointY;
}

- (UILabel *)creatTitleLabelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:16.0f];
    label.textColor = COLOR_333333;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title ? : @"";
    return label;
}

#pragma mark - action

- (void)didTapTimeRecordAnalyze:(UIButton *)button
{
    HourlyRecordAnalyzeViewController *vc = [[UIStoryboard storyboardWithName:@"Analyze" bundle:nil] instantiateViewControllerWithIdentifier:@"HourlyRecordAnalyzeViewController"];
    vc.date = self.date;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self initView];
    });
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    [_contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self reloadViewWithDate:date];
}

@end
