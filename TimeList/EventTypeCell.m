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
    self.backgroundColor = [UIColor whiteColor];
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
    
    [self setCanEditableWithView:_showView];
    
    [self addEditButtons];
    
    [self addSubview:_showView];
    
}

- (void)configWithData:(id)data deleteBlock:(EditableCellDeleteBlock)deleteBlock editBlock:(EditableCellEditBlock)editBlock
{
    self.deleteBlock = deleteBlock;
    self.editBlock = editBlock;
    EventTypeModle *model = (EventTypeModle *)data;
    _showView.titleTextField.text = model.title?:@"";
    _showView.iconView.backgroundColor = model.color?:[UIColor blackColor];
}


- (void)addEditButtons
{
    self.sideslipCellLimitScrollMargin = 0.0f;
    self.sideslipLeftLimitMargin = 0;
    self.sideslipRightLimitMargin = 0;
    
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-70-70, 0, 70, defautlCellHeight)];
    editButton.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    editButton.tag = 1;
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-70, 0, 70, defautlCellHeight)];
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
