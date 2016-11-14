//
//  LYWTimeTool.h
//  分秒
//
//  Created by Leo的Mac on 16/11/7.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYWTimeTool : NSObject

/*  整型转化字符串 */
+ (NSString *)getFormatTimeWithTimeInterval:(NSInteger)timeInterval;
/*  字符串转化整型 */
+ (float)getTimeIntervalWithFormatTime:(NSString *)format;


@end
