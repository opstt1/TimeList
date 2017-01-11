//
//  UIViewController+BackButtonHandler.h
//  TimeList
//
//  Created by LiHaomiao on 2017/1/11.
//  Copyright © 2017年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>

@optional

- (BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (BackButtonHandler)<BackButtonHandlerProtocol>

@end
