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
#import "IQKeyboardManager.h"
#import "EventTypeCell.h"
#import "EventTypeModel.h"
#import "EventTypeListViewController.h"
#import "EventTypeSelectView.h"
#import "UIView+Toast.h"

@interface HourlyRecordCreateView()

@property (nonatomic, readwrite, strong) UILabel *startTimeLabel;
@property (nonatomic, readwrite, strong) UILabel *endTimeLabel;

@property (nonatomic, readwrite, strong) NSDate *startDate;
@property (nonatomic, readwrite, strong) NSDate *endDate;
@property (nonatomic, readwrite, strong) UITextView *textView;

@property (nonatomic, readwrite, strong) HourlyRecordModel *model;
@property (nonatomic, readwrite, strong) UIDatePicker *startPicker;
@property (nonatomic, readwrite, strong) UIDatePicker *endPicker;

@property (nonatomic, readwrite, strong) EventTypeModel *eventTypeModel;

@property (nonatomic, readwrite, strong) EventTypeDetailSubView *typeView;
@property (nonatomic, readwrite, strong) UILabel *typeViewTipLabel;

@property (nonatomic, readwrite, strong) EventTypeSelectView *selectTypeView;

/**
 允许最早的开始时间
 */
@property (nonatomic, readwrite, strong) NSDate *allowEarlyStartDate;

@end


@implementation HourlyRecordCreateView

+ (HourlyRecordCreateView *)editWithModel:(HourlyRecordModel *)model allowEarlyStartDate:(NSDate *)allowEarlyStartDate complete:(HourlyRecordCreateBlock)complete
{
    HourlyRecordCreateView *view = [self editWithModel:model complete:complete];
    view.allowEarlyStartDate = allowEarlyStartDate;
    return view;
}

+ (HourlyRecordCreateView *)editWithModel:(HourlyRecordModel *)model complete:(HourlyRecordCreateBlock)complete
{
    HourlyRecordCreateView *view = [self create];
    view.complete = complete;
    view.model = model;
    [view editInitView];
    return view;
}
+ (HourlyRecordCreateView *)createWithStartDate:(NSDate *)startDate complete:(HourlyRecordCreateBlock)complete
{
    HourlyRecordCreateView *view = [self createWithComplete:complete];
    if ( startDate ){
        view.allowEarlyStartDate = startDate;
        view.startDate = startDate;
        view.startPicker.date = startDate;
    }
    return view;
}

+ (HourlyRecordCreateView *)createWithComplete:(HourlyRecordCreateBlock)complete
{
    HourlyRecordCreateView *view = [self create];
    view.complete = complete;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view textViewBecomeFirstRespender];
    });
    return view;
}

+ (HourlyRecordCreateView *)create
{
    CGRect frame = CGRectMake(0, 16, UISCREEN_WIDTH, UISCREEN_HEIGHT-15);
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
    [self creatSaveAndCloseButton];
    [self createEventTypeSelectView];
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

//创建一个内容编写view
- (void)creatTextView
{
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 64+ 60, UISCREEN_WIDTH - (15 * 2), 100)];
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    _textView.layer.borderWidth = 0.5f;
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.textColor = COLOR_333333;
    [self addSubview:_textView];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

//创建一个事件选择view
- (void)creatTimeSelectView
{
    
    _startTimeLabel = [UILabel new];
    _endTimeLabel = [UILabel new];
    
    NSString *timeStr = [NSDate stringFromDay:[NSDate date] formatStr:@"HH:mm"];
    
    int i = 0;
    for ( UILabel *label in @[_startTimeLabel, _endTimeLabel] ){
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(i*(UISCREEN_WIDTH/2), UISCREEN_HEIGHT-200, UISCREEN_WIDTH/2, 200)];
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
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*(UISCREEN_WIDTH/2), UISCREEN_HEIGHT-230, UISCREEN_WIDTH/2, 30)];
        view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
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
    UIView *backLayer = [UIView new];
    backLayer.backgroundColor = [UIColor whiteColor];
    backLayer.frame = CGRectMake(0, 0, self.width, 49);
    [self addSubview:backLayer];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 60, 49)];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [saveButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [saveButton addTarget:self action:@selector(didTapSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-15-60, 0, 60, 49)];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [closeButton addTarget:self action:@selector(didTapCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:saveButton];
    [self addSubview:closeButton];
    
}

- (void)createEventTypeSelectView
{
    _typeView = [[EventTypeDetailSubView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT-230-defautlCellHeight-2, UISCREEN_WIDTH, defautlCellHeight)];
    _typeView.titleTextField.enabled = NO;
    _typeViewTipLabel = [[UILabel alloc] initWithFrame:_typeView.frame];
    _typeViewTipLabel.y = 0;
    _typeViewTipLabel.textColor = COLOR_666666;
    _typeViewTipLabel.textAlignment = NSTextAlignmentCenter;
    _typeViewTipLabel.text = @"请点击选择类型";
    [_typeView addSubview:_typeViewTipLabel];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSelectType:)];
    [_typeView addGestureRecognizer:gesture];
    
    [self addSubview:_typeView];
}

//通过编辑进入，修改默认值
- (void)editInitView
{
    if ( !_model ){
        return;
    }
    _textView.text = _model.content;
    
    _startPicker.date = _model.startDate;
    _endPicker.date = _model.endDate;
    self.startDate = _model.startDate;
    self.endDate = _model.endDate;
    
    if ( [_model.eventTypeModel.identifier isEqualToString:@""] ){
        return;
    }
    
    self.eventTypeModel = _model.eventTypeModel;
}

#pragma mark -

- (void)datePickerValueChanged:(UIDatePicker *)sender
{
    if ( sender.tag == 0 ){
        self.startDate = [sender date];
    }
    if ( sender.tag == 1 ){
        self.endDate = [sender date];
    }
}

#pragma mark - set

- (void)setStartDate:(NSDate *)startDate
{
    _startDate = startDate;
    NSString *timeStr = [NSDate stringFromDay:startDate formatStr:@"HH:mm"];
    _startTimeLabel.text = timeStr;
}

- (void)setEndDate:(NSDate *)endDate
{
    _endDate = endDate;
    NSString *timeStr = [NSDate stringFromDay:endDate formatStr:@"HH:mm"];
    _endTimeLabel.text = timeStr;
}

- (void)setEventTypeModel:(EventTypeModel *)eventTypeModel
{
    _eventTypeModel = eventTypeModel;
    if ( !_typeView || !eventTypeModel ){
        return;
    }
    
    _typeView.titleTextField.text = eventTypeModel.title;
    _typeView.iconView.backgroundColor = eventTypeModel.color;
    _typeViewTipLabel.hidden = YES;
}

#pragma mark - action 

//点击选择类型
- (void)didTapSelectType:(id)sender
{
    WEAK_OBJ_REF(self);
    CGFloat height = UISCREEN_HEIGHT-_typeView.y-_typeView.height-10-14;
    if ( !_selectTypeView  ){
        _selectTypeView = [[EventTypeSelectView alloc] initWithFrame:CGRectMake(_typeView.x, _typeView.y+_typeView.height, _typeView.width, height)];
        
        _selectTypeView.bvBlock = ^(id result ){
            STRONG_OBJ_REF(weak_self);
            if ( strong_weak_self && result && [result isKindOfClass:[EventTypeModel class]] ){
                strong_weak_self.eventTypeModel = result;
                [strong_weak_self didTapSelectType:sender];
            }
        };
        
        _selectTypeView.height = 0.0f;
        [self addSubview:_selectTypeView];
        [UIView animateWithDuration:0.7 animations:^{
            _selectTypeView.height = height;
        } completion:^(BOOL finished) {
            _selectTypeView.height = height;
        }];
        
    }else{
        
        [UIView animateWithDuration:0.7 animations:^{
            _selectTypeView.height = 0;
        } completion:^(BOOL finished) {
            [_selectTypeView removeFromSuperview];
            _selectTypeView = nil;
        }];
    }
    
}

- (void)textViewBecomeFirstRespender
{
    [self.textView becomeFirstResponder];
}

- (void)show
{
    CGPoint center = self.center;
    self.centerY =  ( self.height ) / 2 * 3;
    [UIView animateWithDuration:0.5 animations:^{
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
    _model.eventTypeModel = _eventTypeModel?:[[EventTypeModel alloc] init];
    
    NSError *error = [_model dataIntegrityWithAllowEarlyStartDate:_allowEarlyStartDate];
    
    if ( error ){
        [self makeToast:error.userInfo[@"info"]?:@"填写内容有错误" duration:1.5 position:[NSValue valueWithCGPoint:self.center]];
        return;
    }
    
    if ( !_model.createDate ){
        _model.createDate = [NSDate date];
    }
    
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
