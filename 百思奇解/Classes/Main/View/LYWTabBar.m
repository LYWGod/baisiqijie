//
//  LYWTabBar.m
//  百思奇解
//
//  Created by LYW on 2016/10/16.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWTabBar.h"
#import "LYWPublishViewController.h"
@interface LYWTabBar()

@property (nonatomic,weak) UIButton *publishBtn;
@end

@implementation LYWTabBar


- (UIButton *)publishBtn
{
    if (!_publishBtn) {
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        publishBtn.frame = CGRectMake(0, 0, self.frame.size.width /5, self.frame.size.height);
        publishBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishBtn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishBtn];
        _publishBtn = publishBtn;

    }
    return _publishBtn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5 ;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
    
    for (UIView *subView in self.subviews) {
        if (subView.class != NSClassFromString(@"UITabBarButton"))
        {
            continue;
        }
        CGFloat buttonX = index * buttonW;
        if (index >=2) {
            buttonX += buttonW;
        }
        subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index ++;
    }
    
    self.publishBtn.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.publishBtn.center = CGPointMake(self.frame.size.width * 0.5, buttonH * 0.5);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    }
    return self;
}

- (void)publishBtnClick
{
    LYWPublishViewController *publish = [[LYWPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:YES completion:nil];
}





@end
