//
//  UITextField+LYWExtension.m
//  百思奇解
//
//  Created by LYW on 2016/10/21.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "UITextField+LYWExtension.h"

@implementation UITextField (LYWExtension)

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    NSString *oldPlaceHolder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceHolder;
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    [self setValue:placeholderColor forKeyPath:@"placeholderLabel.textColor"];

}


//get方法
- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:@"placeholderLabel.textColor"];
}


@end
