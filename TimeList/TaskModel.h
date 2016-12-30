//
//  TaskModel.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/12.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDBManager.h"

@class TaskModel;

TaskModel * rs2logkeeper(FMResultSet *rs);

typedef NS_ENUM(NSInteger, TaskModelStatus)
{
    TaskUndone,
    TaskHasBeenDone,
    TaskDefaultStauts
};

@interface TaskModel : NSObject<NSCopying>


#pragma mark - Required

@property (nonatomic, readwrite, strong  ) NSString *localId;

/**
 task title（Required）
 */
@property (nonatomic, readwrite, strong) NSString *title;


/**
 task status
 */
@property (nonatomic, readwrite, assign) TaskModelStatus status;

/**
 task importance  0 ~ 10  default: 5
 */
@property (nonatomic, readwrite, assign) NSInteger importance;

@property (nonatomic, readwrite, strong) NSDate *createDate;

#pragma mark - Optional


/**
 task decs (Optional)
 */
@property (nonatomic, readwrite, strong) NSString *desc;

/**
 task start time
 */
@property (nonatomic, readwrite, strong) NSDate *startTime;

/**
 task summarize
 */
@property (nonatomic, readwrite, strong) NSString *summarize;


#pragma mark - viewmodel

@property (nonatomic, readwrite, assign ) NSInteger fullStarCount;

@property (nonatomic, readwrite, assign) BOOL hasHalfStar;

@property (nonatomic, readwrite, strong) NSString *starTimeStr;

@property (nonatomic, readwrite, assign) CGFloat leftLimitMargin;

@property (nonatomic, readwrite, assign) CGFloat rightLimitMargin;

#pragma mark -

- (BOOL)dataIntegrity;

- (void)createSuccess;

- (void)remove;

@end


extern NSString *const TaskModelStatusKey;
extern NSString *const TaskModelImportanceKey;
extern NSString *const TaskModelLocalIdKey;
