//
//  NSCalendar+Extension.m
//  封装时间判读
//
//  Created by Leo的Mac on 16/8/10.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "NSCalendar+Extension.h"

@implementation NSCalendar (Extension)

+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}

@end
