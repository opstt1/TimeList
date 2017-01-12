//
//  EventTpyeCell.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EventTypeCell.h"
#import "Constants.h"
#import "EventTypeModle.h"


@interface EventTypeCell()

@property (nonatomic, readwrite, strong) UIView *iconView;
@property (nonatomic, readwrite, strong) UILabel *titleLabel;

@end

@implementation EventTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( !self ){
        return nil;
    }
    [self p_initCell];
    return self;
}


- (void)p_initCell
{
    _iconView = [[UIView alloc] initWithFrame:CGRectMake(15, (defautlCellHeight-14)/2, 14, 14)];
    _iconView.layer.cornerRadius = _iconView.width/2;
    [self addSubview:_iconView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+_iconView.width+15, (defautlCellHeight-20)/2, UISCREEN_WIDTH - (15+_iconView.width+15) - 15.0f , 20.0f)];
    _titleLabel.font = SYSTEM_FONT_15;
    _titleLabel.textColor = COLOR_666666;
    
    [self addSubview:_titleLabel];
    
}

- (void)configWithData:(id)data deleteBlock:(EditableCellDeleteBlock)deleteBlock editBlock:(EditableCellEditBlock)editBlock
{
    EventTypeModle *model = (EventTypeModle *)data;
    _titleLabel.text = model.title?:@"";
    _iconView.backgroundColor = model.color?:[UIColor blackColor];
}


@end
