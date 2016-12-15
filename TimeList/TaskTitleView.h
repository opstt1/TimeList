//
//  TaskTitleView.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/15.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseView.h"

typedef void(^TaskTitleViewHandler)(id result);

static CGFloat const kTitleLableHeight = 40.0f;
static CGFloat const kTitleLableWidth = 110.0f;

@interface TaskTitleView : BaseView

@property (nonatomic, readwrite, copy) TaskTitleViewHandler handler;

+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame actionHandler:(TaskTitleViewHandler)handler;

+ (id)creatWithTitle:(NSString *)title isMust:(BOOL)isMust frame:(CGRect)frame;

- (void)creatPublicViewWithTitle:(NSString *)title isMust:(BOOL)isMust;

- (void)addBottomLineWithFrame:(CGRect)frame;

@end
