//
//  NSDate+Day.m
//  PPYToolkit
//
//  Created by hale on 14-3-13.
//  Copyright (c) 2014年 Tips4app Inc. All rights reserved.
//

#import "NSDate+Day.h"

@implementation NSDate (Day)
- (NSDate *)beginningOfDay
{
    const NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [[NSCalendar currentCalendar]components:flags fromDate:self];
    return [[NSCalendar currentCalendar]dateFromComponents:comps];
}

- (NSDate *)endOfDay
{
    const NSUInteger flags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSDateComponents *comps = [[NSCalendar currentCalendar]components:flags fromDate:self];
    comps.hour = 23;
    comps.minute = 59;
    comps.second = 59;
    return [[NSCalendar currentCalendar]dateFromComponents:comps];
}

- (BOOL)isSameDay:(NSDate *)day
{
    if (!day) {
        return NO;
    }
    
    const NSUInteger flags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    
    NSDateComponents *comps1 = [[NSCalendar currentCalendar]components:flags fromDate:self];
    NSDateComponents *comps2 = [[NSCalendar currentCalendar]components:flags fromDate:day];
    
    return (comps1.year == comps2.year && comps1.month == comps2.month && comps1.day == comps2.day);
}

- (NSDate *)dayByAddingDays:(NSInteger)days
{
    NSDate *begin = [self beginningOfDay];
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    comps.day = days;
    return [[NSCalendar currentCalendar]dateByAddingComponents:comps toDate:begin options:0];
}

- (NSInteger)daysSinceDay:(NSDate *)day
{
    NSDate *begin = [day beginningOfDay];
    NSDate *end = [self beginningOfDay];
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitDay fromDate:begin toDate:end options:0];
    return components.day;
}

- (NSComparisonResult)compareWithDay:(NSDate *)anotherDay;
{
    NSDate *day1 = [self beginningOfDay];
    NSDate *day2 = [anotherDay beginningOfDay];
    return [day1 compare:day2];
}

- (NSComparisonResult)compareWithWeek:(NSDate *)other
{
    NSDate *week1 = [self beginningOfWeek];
    NSDate *week2 = [other beginningOfWeek];
    
    return [week1 compare:week2];
}

- (NSComparisonResult)compareWithMonth:(NSDate *)anotherDay
{
    NSDate *day1 = [self beginningOfMonth];
    NSDate *day2 = [anotherDay beginningOfMonth];
    return [day1 compare:day2];
}

- (NSDate *)dayByAddingMonths:(NSInteger)months
{
    NSDate *begin = self;
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    comps.month = months;
    return [[NSCalendar currentCalendar]dateByAddingComponents:comps toDate:begin options:0];
}

- (NSDate *)dayByAddingYears:(NSInteger)years
{
    NSDate *begin = self;
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    comps.year = years;
    return [[NSCalendar currentCalendar]dateByAddingComponents:comps toDate:begin options:0];
}

- (NSInteger)year
{
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

- (NSInteger)month
{
     NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)day
{
    NSDateComponents *components = [[NSCalendar currentCalendar]components:NSCalendarUnitDay fromDate:self];
    return components.day;
}

- (NSDate *)firstWeekBeginningOfMonth
{
    NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday;
    NSDateComponents *componentsCurrentDate = [[NSCalendar currentCalendar] components:flags fromDate:self];
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = 1;
    componentsNewDate.weekday = [NSCalendar currentCalendar].firstWeekday;
    
    return [[NSCalendar currentCalendar] dateFromComponents:componentsNewDate];
}

- (NSDate *)beginningOfWeek
{
    NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsCurrentDate = [calendar components:flags fromDate:self];
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = componentsCurrentDate.weekOfMonth;
    componentsNewDate.weekday = calendar.firstWeekday;
    
    return [calendar dateFromComponents:componentsNewDate];
}

- (BOOL)isSameMonth:(NSDate *)other
{
    if (!other) {
        return NO;
    }
    
    const NSUInteger flags = (NSCalendarUnitYear | NSCalendarUnitMonth);
    
    NSDateComponents *comps1 = [[NSCalendar currentCalendar]components:flags fromDate:self];
    NSDateComponents *comps2 = [[NSCalendar currentCalendar]components:flags fromDate:other];
    
    return (comps1.year == comps2.year && comps1.month == comps2.month);
}

- (BOOL)isSameYear:(NSDate *)other
{
    if (!other) {
        return NO;
    }
    
    const NSUInteger flags = (NSCalendarUnitYear);
    
    NSDateComponents *comps1 = [[NSCalendar currentCalendar]components:flags fromDate:self];
    NSDateComponents *comps2 = [[NSCalendar currentCalendar]components:flags fromDate:other];
    
    return (comps1.year == comps2.year);
}

- (BOOL)isSameWeek:(NSDate *)other
{
    NSDate *week1 = [self beginningOfWeek];
    NSDate *week2 = [other beginningOfWeek];
    
    return [week1 isEqual:week2];
}

- (BOOL)isSameMinute:(NSDate *)other
{
    if ( !other ){
        return NO;
    }
    if ( ![self isSameDay:other] ){
        return NO;
    }
    
    const NSUInteger flags = (NSCalendarUnitHour | NSCalendarUnitMinute );
    
    NSDateComponents *comps1 = [[NSCalendar currentCalendar]components:flags fromDate:self];
    NSDateComponents *comps2 = [[NSCalendar currentCalendar]components:flags fromDate:other];
    
    return (comps1.minute == comps2.minute && comps1.hour == comps2.hour );
}
- (NSDate *)beginningOfMonth
{
    const NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *comps = [[NSCalendar currentCalendar]components:flags fromDate:self];
    return [[NSCalendar currentCalendar]dateFromComponents:comps];
}

- (NSInteger)weekOfMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self];
    return components.weekOfMonth;
}

+ (NSString *)stringFromDay:(NSDate *)date
{
   return  [self stringFromDay:date formatStr:nil];
}

+ (NSString *)stringFromDay:(NSDate *)date formatStr:(NSString *)formatStr
{
    if ( !formatStr ){
        formatStr = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *formatter;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:formatStr];
    }
    return [formatter stringFromDate:date];

}
@end
