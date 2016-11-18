//
//  LYWLoginOrRegistBtn.m
//  百思奇解
//
//  Created by LYW on 2016/10/20.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWLoginOrRegistBtn.h"

@implementation LYWLoginOrRegistBtn

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.LYW_Y = 0;
    self.imageView.LYW_centerX = self.LYW_W * 0.5;

    self.titleLabel.LYW_X = 0;
    self.titleLabel.LYW_Y = self.imageView.LYW_H;
    self.titleLabel.LYW_W = self.LYW_W;
    self.titleLabel.LYW_H = self.LYW_H - self.imageView.LYW_H;
    
    
}

@end
