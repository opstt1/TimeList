//
//  EventTpyeCell.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/12.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import "EditableTableViewCell.h"
#import "BaseView.h"

@interface EventTypeDetailSubView : BaseView

@property (nonatomic, readwrite, strong) UIView *iconView;
@property (nonatomic, readwrite, strong) UITextField *titleTextField;


@end


@interface EventTypeCell : EditableTableViewCell


- (void)enableEdit:(BOOL)enable;

@end
