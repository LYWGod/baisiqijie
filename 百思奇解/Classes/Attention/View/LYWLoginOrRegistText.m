//
//  LYWLoginOrRegistText.m
//  百思奇解
//
//  Created by LYW on 2016/10/21.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWLoginOrRegistText.h"
#define LYWPlaceholderDefaultColor [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];

#define LYWPlaceholderFocusColor [UIColor whiteColor];

@implementation LYWLoginOrRegistText



- (BOOL)becomeFirstResponder
{
    self.placeholderColor = LYWPlaceholderFocusColor;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.placeholderColor = LYWPlaceholderDefaultColor;
    return [super resignFirstResponder];
}









@end
