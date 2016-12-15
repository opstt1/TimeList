//
//  TastListTableViewCell.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/13.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "TaskListTableViewCell.h"
#import "Constants.h"
#import "Toolkit.h"
#import "TaskModel.h"

#define OPSSideslipCellLeftLimitScrollMargin 30
#define OPSSideslipCellRightLimitScrollMargin 60

@interface TaskListTableViewCell()

@property (nonatomic, readwrite, strong) UILabel *timeLabel;
@property (nonatomic, readwrite, strong) UILabel *titleLabe1;
@property (nonatomic, readwrite, strong) NSArray *starsList;
@property (nonatomic, readwrite, strong) TaskModel *taskModel;


@end

@implementation TaskListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( !self ) return nil;
    [self p_initCell];
    return self;
}

#pragma mark  - p_init
- (void)p_initCell
{
    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, UISCREEN_WIDTH-10, 60)];
    containView.backgroundColor = [UIColor redColor];
    containView.layer.cornerRadius = 10.0f;
    CGFloat width =  UISCREEN_WIDTH - 5 - 5 - 15 - 15;
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, width, 10)];
    _timeLabel.textColor = COLOR_666666;
    _timeLabel.font = [UIFont systemFontOfSize:13];
    
    _titleLabe1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, width, 20)];
    _titleLabe1.textColor = COLOR_333333;
    _titleLabe1.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [containView addSubview:_timeLabel];
    [containView addSubview:_titleLabe1];
    
    CGFloat pointX = 15.0f;
    NSMutableArray *starsList = [NSMutableArray array];
    for ( int  i = 0; i < 5; ++i ){
        UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(pointX, 15+30, 18, 18)];
        starView.layer.contents = (id)[UIImage imageNamed:@"star_gray"].CGImage;
        [containView addSubview:starView];
        [starsList addObject:starView];
        pointX += 18 + 0.5;
    }
    _starsList = [NSArray arrayWithArray:starsList];
    
    [self setCanEditableWithView:containView];
    [self addEditButtons];
    
    [self addSubview:containView];
}

- (void)addEditButtons
{
    UIButton *taskDoneButton = [[UIButton alloc] initWithFrame:CGRectMake( UISCREEN_WIDTH-70-5, 5,  70, 60)];
    [taskDoneButton addTarget:self action:@selector(didTapDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    taskDoneButton.backgroundColor = [UIColor greenColor];
    taskDoneButton.layer.cornerRadius = 10.0f;
    [taskDoneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self addSubview:taskDoneButton];
    [self addButton:taskDoneButton isLeft:NO];
}



#pragma mark - config

- (void)configWithData:(id)data
{
    if ( !data || ![data isKindOfClass:[TaskModel class]]  ){
        return;
    }
    self.taskModel = (TaskModel *)data;
    _titleLabe1.text = _taskModel.title ?: @"";
    _timeLabel.text = _taskModel.starTimeStr ? : @"";
    
    WEAK_OBJ_REF(self);
    [_starsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *starView = (UIView *)obj;
        if ( idx + 1 <= weak_self.taskModel.fullStarCount ){
            starView.layer.contents = (id)[UIImage imageNamed:@"star_yellow"].CGImage;
            return;
        }
        if ( idx + 1 == weak_self.taskModel.fullStarCount){
            starView.layer.contents = (id)[UIImage imageNamed:@"star-half-yellow"].CGImage;
            return;
        }
        starView.layer.contents = (id)[UIImage imageNamed:@"star_gray"].CGImage;
    }];
    
    switch (_taskModel.status) {
        case TaskUndone:
            self.containView.backgroundColor = [UIColor redColor];
            break;
            
        default:
            self.containView.backgroundColor = [UIColor greenColor];
            break;
    }
    
    
}

#pragma mark - action

- (void)didTapDoneButton:(id)sender
{
    if( !self.containView ){
        return;
    }
    self.containView.backgroundColor = [UIColor greenColor];
}

@end
