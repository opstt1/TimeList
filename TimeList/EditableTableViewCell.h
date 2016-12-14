//
//  EditableTableViewCell.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/14.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditableTableViewCell : UITableViewCell

@property (nonatomic, readwrite, assign) BOOL editable;
@property (nonatomic, readwrite, strong) UIView *containView;


- (void)setCanEditableWithView:(UIView *)containView;

- (void)addButton:(UIButton *)button isLeft:(BOOL)isLeft;

@end
