//
//  SheetMaskView.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

typedef void(^antionHandler)(id result);

@interface SheetMaskView : BaseView

@property (nonatomic, readwrite, copy) antionHandler handler;


- (void)showWithSuperView:(UIView *)superView;
- (void)dismiss;

@end
