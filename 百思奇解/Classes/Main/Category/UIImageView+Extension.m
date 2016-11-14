//
//  UIImageView+Extension.m
//  封装图片设置为圆形
//
//  Created by Leo的Mac on 16/8/8.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImage+EXtension.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (Extension)

- (void)setHeader:(NSString *)url
{
    //画圆
    [self setCircleIcon:url];
}

//画圆
- (void)setCircleIcon:(NSString *)url
{
    UIImage *placeHolder = [UIImage circleImage:@"defaultUserIcon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //如果图片下载失败则返回
        if (image == nil) return;
        //给图片画圆
        self.image = [image circleImage];
    }];
    
}

//本身就是形状
- (void)setRectIcon:(NSString *)url
{
    UIImage *placeHolder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder];
}


@end
