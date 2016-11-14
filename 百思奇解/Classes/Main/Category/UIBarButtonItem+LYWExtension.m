//
//  UIBarButtonItem+LYWExtension.m
//  百思奇解
//
//  Created by LYW on 2016/10/16.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "UIBarButtonItem+LYWExtension.h"

@implementation UIBarButtonItem (LYWExtension)


+ (UIBarButtonItem *)itemWithimage:(NSString *)image highlightedImage:(NSString *)highlightImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.LYW_size = btn.currentImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
