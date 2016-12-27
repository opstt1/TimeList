//
//  HourlyRecordCreateView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/27.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordCreateView.h"
#import "Constants.h"

@interface HourlyRecordCreateView()

@property (nonatomic, readwrite, strong) UILabel *startTimeLabel;
@property (nonatomic, readwrite, strong) UILabel *endTimeLabel;

@property (nonatomic, readwrite, strong) NSDate *startDate;
@property (nonatomic, readwrite, strong) NSDate *endDate;

@end


@implementation HourlyRecordCreateView


+ (HourlyRecordCreateView *)create
{
    CGRect frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT);
    HourlyRecordCreateView *view = [[HourlyRecordCreateView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [[[UIApplication sharedApplication].delegate window] addSubview:view];
    [view show];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( !self ){
        return nil;
    }
    [self creatTextView];
    [self creatTimeSelectView];
    return self;
}

- (instancetype)init
{
    self = [super init];
    if ( !self ){
        return nil;
    }
    return self;
}



- (void)creatTextView
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 100, UISCREEN_WIDTH - (15 * 2), 150)];
    textView.layer.borderColor = [UIColor blackColor].CGColor;
    textView.layer.borderWidth = 0.5f;
    textView.font = [UIFont systemFontOfSize:16.0f];
    textView.textColor = COLOR_333333;
    [self addSubview:textView];
}


- (void)creatTimeSelectView
{
    _startTimeLabel = [UILabel new];
    _endTimeLabel = [UILabel new];
    int i = 0;
    for ( UILabel *label in @[_startTimeLabel, _endTimeLabel] ){
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(i*(UISCREEN_WIDTH/2), UISCREEN_HEIGHT-201, UISCREEN_WIDTH/2, 200)];
        picker.datePickerMode = UIDatePickerModeTime;
        picker.backgroundColor = [UIColor whiteColor];
        picker.tag = i;
        [picker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:picker];
        
        //添加一些显示信息的view
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*(UISCREEN_WIDTH/2), UISCREEN_HEIGHT-231, UISCREEN_WIDTH/2, 30)];
        view.backgroundColor = [UIColor greenColor];
        label.frame = CGRectMake(view.frame.size.width/2, 5, view.frame.size.width/2-3, 20);
        label.textColor = [UIColor colorWithRed:0.9 green:0 blue:0 alpha:0.8];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 20)];
        nameLabel.font = [UIFont systemFontOfSize:15.0f];
        if ( i == 0 ){
            nameLabel.text = @"开始:";
        }else{
            nameLabel.text = @"结束:";
        }
        [view addSubview:nameLabel];
        [view addSubview:label];
        
        [self addSubview:view];
        ++i;
    }
//    UIDatePicker *
}

- (void)show
{
    CGPoint center = self.center;
    self.centerY =  ( self.height ) /2 * 3;
    [UIView animateWithDuration:1.0 animations:^{
        self.centerY = center.y;
    } completion:^(BOOL finished) {
        self.centerY = center.y;
        [self addGesture];
    }];
}

- (void)addGesture
{
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [self addGestureRecognizer:gest];
}

- (void)dismiss:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.y = UISCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark -

- (void)datePickerValueChanged:(UIDatePicker *)sender
{
    NSString *timeStr = [NSDate stringFromDay:[sender date] formatStr:@"HH:mm"];
    
    NSLog(@"datee : %@ %@",[sender date],timeStr);
    if ( sender.tag == 0 ){
        _startDate = [sender date];
        _startTimeLabel.text = timeStr;
    }
    if ( sender.tag == 1 ){
        _endDate = [sender date];
        _endTimeLabel.text = timeStr;
    }
}
@end
