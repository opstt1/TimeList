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
@property (nonatomic, readwrite, strong) UIButton *selectButton;

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
    _contetView.iconView.layer.borderWidth = 0.5f;
    _contetView.iconView.layer.borderColor = [UIColor blackColor].CGColor;
    _contetView.titleTextField.delegate = self;
    
    [self addSubview:_contetView];
    
    NSLog(@"couuuuu: __ %d",(int)[EventTypeManager shareManager].unUseColors.count);
    [[EventTypeManager shareManager].unUseColors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self p_addColorButton:(UIColor *)obj index:idx];
    }];
    
    [self addNavigationButton];
    
}

- (void)addNavigationButton
{
    UIView *ngView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 42.0f)];
    ngView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self addSubview:ngView];
    
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-15-50, 0, 50, 42)];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(didTapDone:) forControlEvents:UIControlEventTouchUpInside];
    [ngView addSubview:doneButton];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 50, 42)];
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
    button.layer.cornerRadius = button.width/2;
    
    [self addSubview:button];
    
}


#pragma mark - action

- (void)didTapColorButton:(UIButton *)button
{
    if ( _selectButton ){
        _selectButton.hidden = NO;
    }
    
    UIColor *color = [EventTypeManager shareManager].unUseColors[button.tag];
    _contetView.iconView.backgroundColor = color;
    _model.identifier = [color hexString];
    _selectButton = button;
    _selectButton.hidden = YES;
}

- (void)didTapDone:(UIButton *)button
{
    if ( _contetView.titleTextField.text && _contetView.titleTextField.text.length > 0 ){
        _model.title = _contetView.titleTextField.text;
    }
    
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
    [UIView animateWithDuration:0.7 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - animation

- (void)show
{
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.7 animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.alpha = 1.0f;
        [self.contetView.titleTextField becomeFirstResponder];
    }];
}

#pragma mark - textFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _model.title = textField.text?:@"";
}
@end
