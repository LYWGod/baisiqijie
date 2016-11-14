//
//  UIImage+EXtension.h
//  封装图片设置为圆形
//
//  Created by Leo的Mac on 16/8/8.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EXtension)

- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;

@end
