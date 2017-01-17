//
//  BaseView.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (UIViewController *)currnetViewController
{
    for ( UIView *next = [self superview]; next; next = next.superview ){
        UIResponder *nextResponder = [next nextResponder];
        if ( [nextResponder isKindOfClass:[UIViewController class]] ){
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
