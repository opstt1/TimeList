//
//  Constants.h
//  card
//
//  Created by Hale Chan on 15/4/7.
//  Copyright (c) 2015年 Papaya Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Toolkit.h"

static NSString *const userDefautlIdKey = @"UserDefautlIdKey";

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UISCREEN_SCALE [UIScreen mainScreen].scale

#define SYSTEM_COLOR 0xFD6E37

#define IS_IPONE_5 (([UIScreen mainScreen].bounds.size.width > 320 )? NO : YES)

#define IS_IPONE_6 (([UIScreen mainScreen].bounds.size.width > 370 && [UIScreen mainScreen].bounds.size.width < 400  )? YES : NO)

#define IS_IPONE_6p (([UIScreen mainScreen].bounds.size.width > 400  )? YES : NO)

#define DEFAULT_PLACEHOLDER_HEADER [UIImage imageNamed:@"me-default-Head-168"]

#define COLOR_BBBBBB [UIColor colorWithRGB:0xBBBBBB]
#define COLOR_666666 [UIColor colorWithRGB:0x666666]
#define COLOR_FD6E37 [UIColor colorWithRGB:0xFD6E37]
#define COLOR_FFFFFF [UIColor colorWithRGB:0xFFFFFF]
#define COLOR_333333 [UIColor colorWithRGB:0x333333]
#define COLOR_F4F4F4 [UIColor colorWithRGB:0xF4F4F4]
#define COLOR_999999 [UIColor colorWithRGB:0x999999]
#define COLOR_FD6E37 [UIColor colorWithRGB:0xFD6E37]
#define COLOR_SYSTEM [UIColor colorWithRGB:0xFD6E37]
#define COLOR_DDDDDD [UIColor colorWithRGB:0xDDDDDD]
static const CGFloat normCellHeight = 44.0f;
static NSString *const defaultNumberString = @"---";



#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#define WEAK_OBJ_REF(obj) __weak typeof(obj) weak_##obj = obj
#define STRONG_OBJ_REF(obj) __strong typeof(obj) strong_##obj = obj

#define PRINT_CALL_STACK NSLog(@"%@",[NSThread callStackSymbols])


#define IMPORTANCE_ARRAY [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]


