//
//  Constants.h
//  card
//
//  Created by Hale Chan on 15/4/7.
//  Copyright (c) 2015年 Papaya Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "TypeDefines.h"
#import "Toolkit.h"

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

static NSString *myOrderVCSBID = @"MyOrdersViewController";   //我的预约
static NSString * const getMoneyRuleUrl = @"http://url.cn/41ZMjXK"; //提现规则url


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


typedef enum{
    CardTypeCommen = 0,     //三次通卡
    CardTypeGym,            //场馆卡
    CardTypeAerobic      //有氧空间卡

    
}CardType;

typedef enum{
    GymFeatureOnLine = 1,  //在线人数
    GymFeatureOpenDoor,    //开店进门
    GymFeatureUnlock,       //锁柜解锁
    GymFeatureShower,        //淋浴
    GymFeatrueTreadmill     //跑步机
}GymFeature;

typedef NS_ENUM(NSInteger, OpenDoorActionState){
    
    OpenDoorActionStateEnter = 1,       //进店
    OpenDoorActionStateLeft,            //离店
    OpenDoorActionStatePause            //暂时离店
};

typedef NS_ENUM(NSInteger, OutDoorState){
    
    OutDoorStateDefault = 0,       //默认
    OutDoorStatePause,              //暂时离店
    OutDoorStateLeft,               //结束健身
};

typedef enum{
    CardButtonTypeOpenDoor = 1,
    CardButtonTypeMyOrder,
    CardButtonTypeOrderCourse,
    CardButtonTypeCoach,    //教练列表
    CardButtonTypeMyCoach,  //我的私教
    CardButtonTypeGymDaily,
    CardButtonTypeBuyVIP,
    CardButtonTypeMyCare,
    CardButtonTypeKonwAbout,
    CardButtonTypeBuyPersonalCoach,
    CardButtonTypeActiveCard,
    CardButtonTypeShower,
    CardButtonTypeBodyMeasure,
    CardButtonTypeTreadMill,    //跑步机
    CardButtonTypePromotion,     //推广佣金
} CardButtonType;


extern NSString *const kWeiboRedirectURI;
extern NSString *const kBasicCellIdentifier;
extern NSInteger const kDefaultCardPrice;
extern NSString *const kServiceTel;
extern NSString *const kGymMessageIdDic;       //场馆最新消息的ID 用于获取场馆动态数 格式: 字典(gymID,msgID)
extern NSString *const kCaculateDatePoint;      //健身计时页退出存储当时的时间戳


