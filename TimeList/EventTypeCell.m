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



@implementation EventTypeDetailSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
    
    _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(15+_iconView.width+15, (defautlCellHeight-20)/2, UISCREEN_WIDTH - (15+_iconView.width+15) - 15.0f , 20.0f)];
    _titleTextField.font = SYSTEM_FONT_15;
    _titleTextField.textColor = COLOR_666666;
    
    [self addSubview:_titleTextField];
    
}

@end

@interface EventTypeCell()

@property (nonatomic, readwrite, strong) EventTypeDetailSubView *showView;

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
    _showView = [[EventTypeDetailSubView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, defautlCellHeight)];
    _showView.titleTextField.enabled = NO;
    [self addSubview:_showView];
    
}

- (void)configWithData:(id)data deleteBlock:(EditableCellDeleteBlock)deleteBlock editBlock:(EditableCellEditBlock)editBlock
{
    EventTypeModle *model = (EventTypeModle *)data;
    _showView.titleTextField.text = model.title?:@"";
    _showView.iconView.backgroundColor = model.color?:[UIColor blackColor];
}


@end
