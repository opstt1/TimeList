//
//  EditableTableViewCell.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/14.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OPSSideslipCellLimitScrollMargin 5

@interface EditableTableViewCell : UITableViewCell

@property (nonatomic, readwrite, assign) BOOL editable;
@property (nonatomic, readwrite, strong) UIView *containView;
@property (nonatomic, readwrite, assign) BOOL canSlideToLeft;
@property (nonatomic, readwrite, assign) CGFloat sideslipLeftLimitMargin;
@property (nonatomic, readwrite, assign) CGFloat sideslipRightLimitMargin;

- (void)setCanEditableWithView:(UIView *)containView;

- (void)addButton:(UIButton *)button isLeft:(BOOL)isLeft;

@end
