//
//  LYWMeTableViewCell.m
//  百思奇解
//
//  Created by LYW on 2016/10/23.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWMeTableViewCell.h"

@implementation LYWMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) {
        return;
    }
    self.imageView.LYW_Y = LYWSmallMargin;
    self.imageView.LYW_H = self.contentView.LYW_H - 2*LYWSmallMargin;
    self.imageView.LYW_W = self.imageView.LYW_H;
}

@end
