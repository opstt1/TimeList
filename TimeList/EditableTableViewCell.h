//
//  EditableTableViewCell.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/14.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditableCellDeleteBlock)(id result);
typedef void(^EditableCellEditBlock)(id result);

@interface EditableTableViewCell : UITableViewCell

@property (nonatomic, readwrite, assign) BOOL editable;
@property (nonatomic, readwrite, strong) UIView *containView;
@property (nonatomic, readwrite, assign) BOOL canSlideToLeft;
@property (nonatomic, readwrite, assign) CGFloat sideslipLeftLimitMargin;
@property (nonatomic, readwrite, assign) CGFloat sideslipRightLimitMargin;
@property (nonatomic, readwrite, assign) CGFloat sideslipCellLimitScrollMargin;

@property (nonatomic, readwrite, copy) NSArray *rightButtons;
@property (nonatomic, readwrite, copy) NSArray *leftButtons;

@property (nonatomic, readwrite, copy) EditableCellEditBlock editBlock;
@property (nonatomic, readwrite, copy) EditableCellDeleteBlock deleteBlock;

- (void)setCanEditableWithView:(UIView *)containView;

- (void)addButton:(UIButton *)button isLeft:(BOOL)isLeft;

- (void)configWithData:(id)data indexPath:(NSIndexPath *)indexPath delegateTarget:(id)delegateTarget;

- (void)configWithData:(id)data deleteBlock:(EditableCellDeleteBlock)deleteBlock editBlock:(EditableCellEditBlock)editBlock;

@end
