//
//  LYWPublishBtn.m
//  百思奇解
//
//  Created by Leo的Mac on 16/11/11.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWPublishBtn.h"

@implementation LYWPublishBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 让文字居中显示
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.LYW_Y = self.LYW_H * 0.15;
    self.imageView.LYW_centerX = self.LYW_W * 0.5;
    
    // 调整文字位置
    self.titleLabel.LYW_W = self.LYW_W;
    self.titleLabel.LYW_H = self.LYW_H - self.imageView.LYW_H;
    self.titleLabel.LYW_X = 0;
    self.titleLabel.LYW_Y = CGRectGetMaxY(self.imageView.frame);
    
}


@end
