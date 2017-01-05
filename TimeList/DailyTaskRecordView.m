//
//  DailyTaskRecordView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/4.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "DailyTaskRecordView.h"
#import "TaskModel.h"
#import "Constants.h"

#define contentLabelWidth UISCREEN_WIDTH-15-10-20-15

static const CGFloat contentLabelPointX = 15+20+10;

@interface DailyTaskRecordView()

@property (nonatomic, readwrite, assign) CGFloat viewHeight;

@end

@implementation DailyTaskRecordView


+ (DailyTaskRecordView *)createWithTaskModel:(TaskModel *)taskModel
{
    DailyTaskRecordView *view = [[DailyTaskRecordView alloc] initWithModel:taskModel];
    
    return view;
}

- (instancetype)initWithModel:(TaskModel *)taskModel
{
    self = [self init];
    
    [self initViewWithModel:taskModel];
    
    return self;
}

- (void)initViewWithModel:(TaskModel *)model
{
    CGFloat statusLabelBottomPoint = [self addStatusLabelWithModel:model];
    
    CGFloat titleLabelBotttomPoint = [self addTitleLabelWithModel:model];
    
    _viewHeight = (titleLabelBotttomPoint > statusLabelBottomPoint ? titleLabelBotttomPoint + 5.0f : statusLabelBottomPoint) + 5.0f;
    
    if ( model.summarize.length > 0 ){
        _viewHeight = [self addSummaryLabelWithModel:model pointY:_viewHeight] + 5.0f;
    }
    
}

- (CGFloat)addStatusLabelWithModel:(TaskModel *)model
{
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 20, 20)];
    statusLabel.layer.cornerRadius = 10.0f;
    statusLabel.layer.masksToBounds = YES;
    statusLabel.textAlignment = NSTextAlignmentCenter;
    
    if ( model.status == TaskHasBeenDone ){
        statusLabel.backgroundColor = [UIColor greenColor];
        statusLabel.textColor = [UIColor blackColor];
    }else{
        statusLabel.backgroundColor = [UIColor redColor];
        statusLabel.textColor = [UIColor whiteColor];
    }
    statusLabel.text = [NSString stringWithFormat:@"%d",(int)model.importance];
    
    [self addSubview:statusLabel];
    
    return 5+20;
}

- (CGFloat)addTitleLabelWithModel:(TaskModel *)model
{
    CGFloat titleLabelHeight = [model.title sizeWithFont:SYSTEM_FONT_16 width:contentLabelWidth height:CGFLOAT_MAX].height;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelPointX, 5, contentLabelWidth, titleLabelHeight)];
    titleLabel.text = model.title;
    titleLabel.font = SYSTEM_FONT_16;
    titleLabel.numberOfLines = 0;
    
    [self addSubview:titleLabel];
    
    return titleLabel.y + titleLabel.height;
}

- (CGFloat)addSummaryLabelWithModel:(TaskModel *)model pointY:(CGFloat)pointY
{
    CGFloat summaryLabelHeight = [model.summarize sizeWithFont:SYSTEM_FONT_15 width:contentLabelWidth height:CGFLOAT_MAX].height;
    UILabel *summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentLabelPointX, pointY, contentLabelWidth, summaryLabelHeight)];
    summaryLabel.text = model.summarize;
    summaryLabel.font = SYSTEM_FONT_15;
    summaryLabel.textColor = COLOR_666666;
    summaryLabel.numberOfLines = 0;
    [self addSubview:summaryLabel];
    
    return summaryLabel.y + summaryLabel.height;
}
@end
