//
//  CreateEvenTypeView.m
//  TimeList
//
//  Created by LiHaomiao on 2017/1/13.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "CreateEvenTypeView.h"
#import "EventTypeManager.h"
#import "Constants.h"
#import "EventTypeCell.h"
#import "EventTypeModle.h"

static CGFloat colorButtonTop = 64 + 44.0f + 60;
static NSInteger onelineButtonCount = 5;
static CGFloat colorButtonWidth = 30.0f;

@interface CreateEvenTypeView()<UITextFieldDelegate>


@property (nonatomic, readwrite, strong) EventTypeDetailSubView *contetView;
@property (nonatomic, readwrite, strong) UIView *colorBackView;
@property (nonatomic, readwrite, strong) EventTypeModle *model;
@end

@implementation CreateEvenTypeView

+ (CreateEvenTypeView *)createWithComplete:(CreateEvenTypeViewBlock)complete
{
    CreateEvenTypeView *view = [[CreateEvenTypeView alloc] initWithFrame:CGRectMake(0, 20, UISCREEN_WIDTH, UISCREEN_HEIGHT-20)];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [[[UIApplication sharedApplication].delegate window] addSubview:view];
    [view show];
    view.complete = complete;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( !self ){
        return nil;
    }
    [self initView];
    _model = [[EventTypeModle alloc] initWithIdentifier:@"" title:@"" isDefault:NO];
    return self;
}


- (void)initView
{
   
    _contetView = [[EventTypeDetailSubView alloc] initWithFrame:CGRectMake(0, 64-20, UISCREEN_WIDTH, defautlCellHeight)];
    [self addSubview:_contetView];
    
    _contetView.iconView.backgroundColor = [UIColor whiteColor];
    _contetView.titleTextField.delegate = self;
    _contetView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_contetView];
    
    [[EventTypeManager shareManager].unUseColors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self p_addColorButton:(UIColor *)obj index:idx];
    }];
    
    [self addNavigationButton];
    
}

- (void)addNavigationButton
{
    UIView *ngView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 42.0f)];
    ngView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    [self addSubview:ngView];
    
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-15-50, 10, 50, 20)];
    doneButton.backgroundColor = [UIColor blackColor];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(didTapDone:) forControlEvents:UIControlEventTouchUpInside];
    [ngView addSubview:doneButton];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 50, 20)];
    closeButton.backgroundColor = [UIColor blackColor];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(didTapClose:) forControlEvents:UIControlEventTouchUpInside];
    [ngView addSubview:closeButton];
}

- (void)p_addColorButton:(UIColor *)color index:(NSInteger)index
{
    CGFloat space = ( UISCREEN_WIDTH - onelineButtonCount * colorButtonWidth ) / (onelineButtonCount + 1);
    
    CGFloat row = (index / onelineButtonCount) + 1;
    CGFloat file = ( index % onelineButtonCount);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(file * (space + colorButtonWidth) + space, (row - 1 ) *(space+colorButtonWidth)+colorButtonTop, colorButtonWidth, colorButtonWidth)];
    button.backgroundColor = color;
    button.tag = index;
    [button addTarget:self action:@selector(didTapColorButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
}


#pragma mark - action

- (void)didTapColorButton:(UIButton *)button
{
    UIColor *color = [EventTypeManager shareManager].unUseColors[button.tag];
    _contetView.iconView.backgroundColor = color;
    _model.identifier = [color hexString];
}

- (void)didTapDone:(UIButton *)button
{
    if ( [_model dataIntegrity] ){
        if ( _complete ){
            _complete(_model);
        }
        [self dismiss];
    }
}

- (void)didTapClose:(UIButton *)button
{
    if ( _complete ){
        _complete(nil);
    }
    [self dismiss];
}

- (void)dismiss
{
    [self removeFromSuperview];
}
#pragma mark - animation

- (void)show
{
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.alpha = 1.0f;
    }];
}

#pragma mark - textFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _model.title = textField.text?:@"";
}
@end
