//
//  LYWRefreshHeard.m
//  百思奇解
//
//  Created by LYW on 2016/11/5.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWRefreshHeard.h"

@interface LYWRefreshHeard ()

@property (nonatomic, weak) UIImageView *logo;

@end

@implementation LYWRefreshHeard

- (void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.textColor = [UIColor redColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor redColor];
    [self setTitle:@"速度下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"速度松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"小蓝正在加载数据..." forState:MJRefreshStateRefreshing];
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"MainTitle"];
    [self addSubview:logo];
    self.logo = logo;
}

/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.LYW_W = self.LYW_W * 0.6;
    self.logo.LYW_H = 30;
    self.logo.LYW_centerX = self.LYW_centerX;
    self.logo.LYW_Y = - 30;
}

@end
