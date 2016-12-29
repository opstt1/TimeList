//
//  HourlyRecordModel.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/28.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordModel.h"
#import "Constants.h"

@implementation HourlyRecordModel

- (void)setContent:(NSString *)content
{
    _content = content;
    _cellHeight = [content sizeWithFont:[UIFont systemFontOfSize:16.0f] width:UISCREEN_WIDTH-30 height:MAXFLOAT].height + 30 + 10;
    
}

- (void)setStartDate:(NSDate *)startDate
{
    _startDate = startDate;
    _startTime = [NSDate stringFromDay:startDate formatStr:@"HH:mm"];
}

- (void)setEndDate:(NSDate *)endDate
{
    _endDate = endDate;
    _endTime = [NSDate stringFromDay:endDate formatStr:@"HH:mm"];
}
@end




@interface HourlyRecordDataSource()


@end

@implementation HourlyRecordDataSource

- (instancetype)init
{
    self = [super init];
    if ( !self ){
        return nil;
    }
    return self;
}



@end
