//
//  UIBarButtonItem+LYWExtension.h
//  百思奇解
//
//  Created by LYW on 2016/10/16.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LYWExtension)


+ (UIBarButtonItem *)itemWithimage:(NSString *)image highlightedImage:(NSString *)highlightImage target:(id)target action:(SEL)action;

@end
