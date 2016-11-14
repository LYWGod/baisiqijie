//
//  NSString+DateExtension.m
//  封装时间工具
//
//  Created by Leo的Mac on 16/8/10.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "NSString+DateExtension.h"

@implementation NSString (DateExtension)

+ (NSString *)formatYearMonthDay:(NSTimeInterval)time
{
    if (time < 0) return @"";
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //注意：这里设置格式：2016：8：10
    [format setDateFormat:@"yyyy年MM月dd日"];
    //[format setDateFormat:@"yy-MM-dd"];
    //如果是这种：那么返回的时间是：2016-08-10
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSString *str = [format stringFromDate:date];
    return str;
}

+ (NSString *)formatHourMinutesSecond:(NSTimeInterval)time
{
    if (time < 0) return @"";
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"HH时mm分ss秒"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    
    NSString *str = [format stringFromDate:date];
    return str;
}

+ (NSString *)formatYearMonthDayHourMinutesSecond:(NSTimeInterval)time
{
    if (time < 0) return @"";
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time/1000];
    
    NSString *str = [format stringFromDate:date];
    return str;
}

@end
