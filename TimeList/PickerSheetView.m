//
//  PickerSheetView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "PickerSheetView.h"
#import "Constants.h"

@interface PickerSheetView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, readwrite, strong) NSArray *titles;
@property (nonatomic, readwrite, assign) NSInteger selectRow;

@end

@implementation PickerSheetView

+ (PickerSheetView *)createWithTitles:(NSArray *)titles superView:(UIView *)superView actionHandler:(antionHandler)handler
{
    PickerSheetView *view = [[PickerSheetView alloc] init];
    [view addPickerWithTitles:titles];
    view.handler = handler;
    [view showWithSuperView:superView];
    return view;
}


- (void)addPickerWithTitles:(NSArray *)titles
{
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-160, UISCREEN_WIDTH, 160)];
    picker.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    _titles = [NSArray arrayWithArray:titles];
    picker.delegate = self;
    picker.dataSource = self;
    _selectRow = 0;
    
    [self addSubview:picker];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-160, 50, 50)];
    [closeButton setTitle:@"Done" forState:UIControlStateNormal];
    [closeButton setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(didTapDoneButton:) forControlEvents:UIControlEventTouchUpInside];
//    closeButton.backgroundColor = [UIColor redColor];
    [self addSubview:closeButton];
}

#pragma mark 实现协议UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_titles count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f;
}

#pragma mark 实现协议UIPickerViewDelegate方法

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_titles objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectRow = row;
}


#pragma mark - action

- (void)didTapDoneButton:(id)sender
{
    if ( self.handler ){
        self.handler(@(_selectRow));
    }
    [self dismiss];
}





@end
