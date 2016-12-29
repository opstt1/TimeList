//
//  HourlyRecordCreateView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/27.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordCreateView.h"
#import "Constants.h"
#import "HourlyRecordModel.h"

@interface HourlyRecordCreateView()

@property (nonatomic, readwrite, strong) UILabel *startTimeLabel;
@property (nonatomic, readwrite, strong) UILabel *endTimeLabel;

@property (nonatomic, readwrite, strong) NSDate *startDate;
@property (nonatomic, readwrite, strong) NSDate *endDate;
@property (nonatomic, readwrite, strong) UITextView *textView;

@property (nonatomic, readwrite, strong) HourlyRecordModel *model;
@property (nonatomic, readwrite, strong) UIDatePicker *startPicker;
@property (nonatomic, readwrite, strong) UIDatePicker *endPicker;

@end


@implementation HourlyRecordCreateView

+ (HourlyRecordCreateView *)editWithModel:(HourlyRecordModel *)model complete:(HourlyRecordCreateBlock)complete
{
    HourlyRecordCreateView *view = [self create];
    view.complete = complete;
    view.model = model;
    [view editInitView];
    return view;
}

+ (HourlyRecordCreateView *)createWithComplete:(HourlyRecordCreateBlock)complete
{
    HourlyRecordCreateView *view = [self create];
    view.complete = complete;
    [view textViewBecomeFirstRespender];
    return view;
}

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
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 400, UISCREEN_WIDTH, UISCREEN_HEIGHT-400);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:layer];
    
    [self creatTextView];
    [self creatTimeSelectView];
    [self creatSaveAndCloseButton];
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
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 70, UISCREEN_WIDTH - (15 * 2), 150)];
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    _textView.layer.borderWidth = 0.5f;
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.textColor = COLOR_333333;
    [self addSubview:_textView];
}

- (void)creatTimeSelectView
{
    
    _startTimeLabel = [UILabel new];
    _endTimeLabel = [UILabel new];
    
    NSString *timeStr = [NSDate stringFromDay:[NSDate date] formatStr:@"HH:mm"];
    
    int i = 0;
    for ( UILabel *label in @[_startTimeLabel, _endTimeLabel] ){
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(i*(UISCREEN_WIDTH/2), UISCREEN_HEIGHT-281, UISCREEN_WIDTH/2, 200)];
        picker.datePickerMode = UIDatePickerModeTime;
        picker.backgroundColor = [UIColor whiteColor];
        picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];;
        picker.tag = i;
        [picker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:picker];
        
        if ( i == 0 ){
            _startPicker = picker;
        }else{
            _endPicker = picker;
        }
        //添加一些显示信息的view
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*(UISCREEN_WIDTH/2), UISCREEN_HEIGHT-311, UISCREEN_WIDTH/2, 30)];
        view.backgroundColor = [UIColor greenColor];
        label.frame = CGRectMake(view.frame.size.width/2, 5, view.frame.size.width/2-3, 20);
        label.textColor = [UIColor colorWithRed:0.9 green:0 blue:0 alpha:0.8];
        label.text = timeStr;
        
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
}

- (void)creatSaveAndCloseButton
{
    CGFloat pointY = UISCREEN_HEIGHT - 10 - 45;
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(50, pointY, 50, 45)];
    [saveButton setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(didTapSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-50-50, pointY - 5, 45, 50)];
    [closeButton setImage:[UIImage imageNamed:@"wrong"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(didTapCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:saveButton];
    [self addSubview:closeButton];
}

- (void)editInitView
{
    if ( !_model ){
        return;
    }
    _textView.text = _model.content;
    _startTimeLabel.text = _model.startTime;
    _endTimeLabel.text = _model.endTime;
    
    _startPicker.date = _model.startDate;
    _endPicker.date = _model.endDate;
}

#pragma mark -

- (void)datePickerValueChanged:(UIDatePicker *)sender
{
    NSString *timeStr = [NSDate stringFromDay:[sender date] formatStr:@"HH:mm"];
    if ( sender.tag == 0 ){
        _startDate = [sender date];
        _startTimeLabel.text = timeStr;
    }
    if ( sender.tag == 1 ){
        _endDate = [sender date];
        _endTimeLabel.text = timeStr;
    }
}

#pragma mark - action 

- (void)textViewBecomeFirstRespender
{
    [self.textView becomeFirstResponder];
}

- (void)show
{
    CGPoint center = self.center;
    self.centerY =  ( self.height ) /2 * 3;
    [UIView animateWithDuration:1.0 animations:^{
        self.centerY = center.y;
    } completion:^(BOOL finished) {
        self.centerY = center.y;
        
    }];
    
    _model = [[HourlyRecordModel alloc] init];
}


- (void)dismiss:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.y = UISCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)didTapSaveButton:(id)sender
{
    _model.content = _textView.text;
    _model.startDate = _startDate?:[NSDate date];
    _model.endDate = _endDate?:[NSDate date];
    _model.creatDate = [NSDate date];
    
    if ( _complete ){
        _complete(_model);
    }
    [self dismiss:sender];
}

- (void)didTapCloseButton:(id)sender
{
    [self dismiss:sender];
}
@end
