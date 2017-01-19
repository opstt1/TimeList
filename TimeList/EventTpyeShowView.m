//
//  EventTpyeShowView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/19.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTpyeShowView.h"
#import "Constants.h"
#import "HourlyRecordModel.h"
#import "AnalyzeData.h"

static CGFloat fontFloat = 13.0f;

@interface EventTpyeShowView()

@property (nonatomic, readwrite, copy) NSArray *types;

@end

@implementation EventTpyeShowView

+ (EventTpyeShowView *)createWithData:(HourlyRecordDataSource *)data
{
    EventTpyeShowView *view = [[EventTpyeShowView alloc] initWithData:data];
    return view;
}

- (instancetype)initWithData:(HourlyRecordDataSource *)data
{
    self = [self init];
    if ( !self ){
        return nil;
    }
    [self calculateData:data];
    [self createShowView];
    return self;
}


- (void)calculateData:(HourlyRecordDataSource *)data
{
    _types = [AnalyzeData eventTypeAnalyzeData:data];
}


- (void)createShowView
{
    CGFloat pointX = 15.0f;
    CGFloat pointY = 0.0f;
    CGFloat labelHeight = 0.0f;
    CGFloat hasWithd = UISCREEN_WIDTH-30;
    
    for ( EventTypeModel *model in _types ){
        CGFloat width = [model.title sizeWithFont:[UIFont systemFontOfSize:fontFloat]].width;
        if ( hasWithd < width + 20 + pointX ){
            hasWithd = UISCREEN_WIDTH-30;
            pointX = 15.0f;
            pointY += 10 + 8;
        }
        CALayer *typeLayer = [CALayer layer];
        typeLayer.frame = CGRectMake(pointX, pointY, 10, 10);
        typeLayer.cornerRadius = 5.0f;
        typeLayer.backgroundColor = model.color.CGColor;
        [self.layer addSublayer:typeLayer];
    
        [self typeLabelWithFrame:CGRectMake(pointX+15, pointY, width, 10) text:model.title];
        pointX += 15 + width + 5;
        
    }
    
    if ( self.bvBlock ){
        self.bvBlock ( [NSNumber numberWithFloat:pointY + 18] );
    }
    self.height = pointY + 18;
    
}

- (UILabel *)typeLabelWithFrame:(CGRect)frame text:(NSString *)text
{
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:frame];
    
    typeLabel.textAlignment = NSTextAlignmentLeft;
    typeLabel.textColor = COLOR_333333;
    typeLabel.font = [UIFont systemFontOfSize:fontFloat];
    typeLabel.text = text;

    [self addSubview:typeLabel];
    
    return typeLabel;
}
@end
