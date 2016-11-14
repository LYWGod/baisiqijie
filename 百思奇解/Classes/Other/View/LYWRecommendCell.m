//
//  LYWRecommendCell.m
//  百思奇解
//
//  Created by LYW on 2016/11/5.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWRecommendCell.h"
#import "UIImageView+WebCache.h"
#import "LYWRecommendController.h"
@interface LYWRecommendCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *perpleAttention;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end



@implementation LYWRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(LYWRecommend *)model
{
    _model = model;
    [self.icon setHeader:model.image_list];
    self.name.text = model.theme_name;
    NSString *subnumber = nil;
    if([model.sub_number integerValue] >= 10000)
    {
        if([model.sub_number integerValue] >= 1000 &&[model.sub_number integerValue] < 10000)
        {
            subnumber = [NSString stringWithFormat:@"%.2f千人关注",[model.sub_number integerValue]/1000.0];
        }
        else
        {
            subnumber = [NSString stringWithFormat:@"%.2f万人关注",[model.sub_number integerValue]/10000.0];
        }
    }
    else
    {
        subnumber = [NSString stringWithFormat:@"%ld人关注",[model.sub_number integerValue]];
    }
    self.perpleAttention.text = subnumber;
}

- (IBAction)btnClick:(UIButton *)sender
{
  LYWLogFunc
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
