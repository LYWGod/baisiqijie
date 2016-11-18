//
//  LYWRefreshFooter.m
//  百思奇解
//
//  Created by LYW on 2016/11/5.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWRefreshFooter.h"

@implementation LYWRefreshFooter

- (void)prepare
{
    [super prepare];
    // 是否需要自动隐藏
    self.automaticallyHidden = YES;
    
    // 是否需要自动刷重新
    self.automaticallyRefresh = NO;
    
    // 设置文字
    self.stateLabel.text = @"小蓝帮你加载";
    self.stateLabel.textColor = [UIColor redColor];
}

@end
