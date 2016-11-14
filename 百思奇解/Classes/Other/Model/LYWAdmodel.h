//
//  LYWAdmodel.h
//  百思奇解
//
//  Created by Leo的Mac on 16/11/14.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYWAdmodel : NSObject

/** 图片URL */
@property (nonatomic,copy) NSString *w_picurl;
/** 点击图片的回调网址 */
@property (nonatomic,copy) NSString *ori_curl;
/** 宽 */
@property (nonatomic, assign) NSInteger w;
/** 高 */
@property (nonatomic, assign) NSInteger h;

@end
