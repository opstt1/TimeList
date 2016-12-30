//
//  TaskAlwaysUseViewController.h
//  TimeList
//
//  Created by LiHaomiao on 2016/12/30.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "BaseViewController.h"

typedef BOOL(^TaskAlwaysUseSelectBlock)(id result);

@interface TaskAlwaysUseViewController : BaseViewController

@property (nonatomic, readwrite, copy) TaskAlwaysUseSelectBlock selectCompelet;


@end
