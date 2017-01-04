//
//  HourlyRecordModel.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/28.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "HourlyRecordModel.h"
#import "Constants.h"
#import "HourlyRecordModel+FMDB.h"

@interface HourlyRecordModel()

@end

@implementation HourlyRecordModel

NSString * const HourlyRecordModelStartDateKey = @"startDate";


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

- (void)setCreateDate:(NSDate *)createDate
{
    _createDate = createDate;
    _identifier = [NSDate stringFromDay:createDate formatStr:@"yyy-MMM-dd HH:mm:ss"];
    NSLog(@"hourly Model identifier : %@", _identifier);
}
@end




@interface HourlyRecordDataSource()


@end

@implementation HourlyRecordDataSource

+ (HourlyRecordDataSource *)createWithDate:(NSDate *)date
{
    [HourlyRecordModel createSqliteTable];
    
    NSDate *begin = [date beginningOfDay];
    NSDate *end = [date endOfDay];
    NSArray *array =  [HourlyRecordModel findOfStartDate:begin toDate:end];
    
    HourlyRecordDataSource *dataSource = [[HourlyRecordDataSource alloc] init];
    
    [dataSource dataSourceWithArray:array];
    [dataSource sortStartDateIsAscending:NO];
    return dataSource;
}

- (instancetype)init
{
    self = [super init];
    if ( !self ){
        return nil;
    }
    return self;
}

@end


@implementation HourlyRecordDataSource (Sort)

- (void)sortStartDateIsAscending:(BOOL)isAscending
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self dataList]];
    NSSortDescriptor *startDateDesc = [NSSortDescriptor sortDescriptorWithKey:HourlyRecordModelStartDateKey ascending:isAscending];
    NSArray *descriptorArray = [NSArray arrayWithObjects:startDateDesc, nil];
    NSArray *sortArray = [array sortedArrayUsingDescriptors:descriptorArray];
    [self dataSourceWithArray:sortArray];
}
@end
