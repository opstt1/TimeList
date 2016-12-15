//
//  PickerSheetView.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "SheetMaskView.h"

@interface PickerSheetView : SheetMaskView

+ (PickerSheetView *)createWithTitles:(NSArray *)titles superView:(UIView *)superView actionHandler:(antionHandler)handler;

@end
