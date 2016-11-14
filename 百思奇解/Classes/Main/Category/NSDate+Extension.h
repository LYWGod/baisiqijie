//
//  NSDate+Extension.h
//  封装时间判读
//
//  Created by Leo的Mac on 16/8/10.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为明天
 */
- (BOOL)isTomorrow;

@end
