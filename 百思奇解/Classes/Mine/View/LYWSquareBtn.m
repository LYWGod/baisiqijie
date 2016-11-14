//
//  LYWSquareBtn.m
//  百思奇解
//
//  Created by LYW on 2016/10/29.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWSquareBtn.h"
#import "UIButton+WebCache.h"
@implementation LYWSquareBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.LYW_W = self.LYW_W * 0.5;
    self.imageView.LYW_H = self.imageView.LYW_W;
    self.imageView.LYW_centerX = self.LYW_W * 0.5;
    self.imageView.LYW_Y = LYWMargin;

    
    self.titleLabel.LYW_X = 0;
    self.titleLabel.LYW_Y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.LYW_W = self.LYW_W;
    self.titleLabel.LYW_H = self.LYW_H - self.imageView.LYW_H - self.imageView.LYW_Y;
   
    
}

-(void)setSquareModel:(LYWSquareModel *)squareModel
{
    _squareModel = squareModel;
    [self setTitle:squareModel.name forState:UIControlStateNormal];
//    [self sd_setImageWithURL:[NSURL URLWithString:squareModel.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    
    [self sd_setImageWithURL:[NSURL URLWithString:squareModel.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
  
}


@end
