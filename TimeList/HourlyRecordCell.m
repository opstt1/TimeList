//
//  HourlyRecordCell.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/28.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordCell.h"
#import "Constants.h"
#import "HourlyRecordModel.h"


@interface HourlyRecordCell()

@property (nonatomic, readwrite, strong) UIView *showRecordView;
@property (nonatomic, readwrite, strong) UILabel *showRecordLabel;
@property (nonatomic, readwrite, strong) UIView *showTypeView;

@end

@implementation HourlyRecordCell

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
    _showTypeView = [[UIView alloc] initWithFrame:CGRectMake(15, 5, 14, 14)];
    _showTypeView.layer.cornerRadius = 7;
    
    _showRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 1)];
    _showRecordView.backgroundColor = [UIColor whiteColor];
    
    _showRecordLabel = [[UILabel alloc] initWithFrame:CGRectMake(14+15+10, 5, contentLabelWidth, 1)];
    _showRecordLabel.font = [UIFont systemFontOfSize:16.0f];
    _showRecordLabel.textColor = COLOR_333333;
    _showRecordLabel.numberOfLines = 0;
    
    [_showRecordView addSubview:_showRecordLabel];
    [_showRecordView addSubview:_showTypeView];
    
    [self setCanEditableWithView:_showRecordView];
    
    [self addEditButtons];
    
    [self addSubview:_showRecordView];
}

//添加删除，修改按钮
- (void)addEditButtons
{
    self.sideslipCellLimitScrollMargin = 0.0f;
    self.sideslipLeftLimitMargin = 0;
    self.sideslipRightLimitMargin = 0;
    
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-70-70, 0, 70, 1)];
    editButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    editButton.tag = 1;
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-70, 0, 70, 1)];
    deleteButton.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    deleteButton.tag = 0;
    
    for ( UIButton *button in @[editButton,deleteButton] ){
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:editButton];
    [self addSubview:deleteButton];
    
    [self addButton:editButton isLeft:NO];
    [self addButton:deleteButton isLeft:NO];
    
    self.canSlideToLeft = YES;
    self.sideslipRightLimitMargin = 70 + 70;
}


- (void)configWithData:(id)data deleteBlock:(EditableCellDeleteBlock)deleteBlock editBlock:(EditableCellEditBlock)editBlock
{
    HourlyRecordModel *model = (HourlyRecordModel *)data;
    _showRecordView.height = model.cellHeight;
    _showRecordLabel.height = _showRecordView.height - 10;
    _showTypeView.centerY = _showRecordLabel.centerY;
    
    _showTypeView.backgroundColor = model.eventTypeModel.color ? :[UIColor grayColor];
    _showRecordLabel.text = model.content;
    
    for ( UIButton *button in self.rightButtons ){
        button.height = _showRecordView.height;
    }
    for ( UIButton *button in self.leftButtons ){
        button.height = _showRecordView.height;
    }
    
    [self layoutIfNeeded];
    
    self.deleteBlock = deleteBlock;
    self.editBlock = editBlock;
    
}


#pragma mark - action

- (void)didTapButton:(UIButton *)sender
{
    if ( sender.tag == 0 ){
        if ( self.deleteBlock ){
            self.deleteBlock(nil);
        }
        return;
    }
    
    if( self.editBlock ){
        self.editBlock(nil);
    }
}

@end
