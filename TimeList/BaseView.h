//
//  BaseView.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BaseViewBlock) (id result);

@interface BaseView : UIView

@property (nonatomic, readwrite, copy) BaseViewBlock bvBlock;

- (UIViewController *)currnetViewController;

@end
