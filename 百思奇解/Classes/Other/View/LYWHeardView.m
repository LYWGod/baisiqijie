//
//  LYWHeardView.m
//  百思奇解
//
//  Created by Leo的Mac on 16/11/14.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWHeardView.h"

@implementation LYWHeardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel.textColor = [UIColor whiteColor];
        self.contentView.backgroundColor = LYWCommonBgColor;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.LYW_X = LYWMargin;
}


@end
