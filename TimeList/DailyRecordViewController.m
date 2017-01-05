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

@interface DailyRecordViewController ()

@property (nonatomic, readwrite, strong) TaskDataSource *taskDataSource;
@property (nonatomic, readwrite, strong) HourlyRecordDataSource *hourlyDataSource;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (nonatomic, readwrite, assign) CGFloat pointY;
@end

@implementation DailyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _pointY = 10.0f;
    [self initTaskView];
    [self initHourlyRecordView];
}


- (void)initWithDate:(NSDate *)date
{
    if ( !date ){
        date = [NSDate date];
    }
    
    self.taskDataSource = [TaskDataSource creatTaksDataWithDate:date];
    [self.taskDataSource sortWithFirstKeyImptanceFromeHeight:YES];
    
    self.hourlyDataSource = [HourlyRecordDataSource createWithDate:date];
    [self.hourlyDataSource sortStartDateIsAscending:YES];
    
    self.title = [NSDate stringFromDay:date formatStr:@"yyyy年MM月dd日"];
    
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
    UILabel *hourlyRecordLabel = [self creatTitleLabelWithTitle:@"时间记录"];
    hourlyRecordLabel.frame = CGRectMake(0, _pointY, UISCREEN_WIDTH, 16);
    [self.contentView addSubview:hourlyRecordLabel];
    
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
@end
