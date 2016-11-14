//
//  UIImage+EXtension.m
//  封装图片设置为圆形
//
//  Created by Leo的Mac on 16/8/8.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "UIImage+EXtension.h"

@implementation UIImage (EXtension)

- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)circleImage:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}


@end
