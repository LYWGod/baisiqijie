//
//  LYWCommentCell.m
//  百思奇解
//
//  Created by LYW on 2016/11/13.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWCommentCell.h"
#import "LYWComment.h"
#import "LYWUser.h"
#import <AVFoundation/AVFoundation.h>

@interface LYWCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *contenttext;
@property (weak, nonatomic) IBOutlet UILabel *agree;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
/** 播放声音的播放器 */
@property (nonatomic,strong) AVPlayer *player;

@end

@implementation LYWCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];

   self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setCommentModel:(LYWComment *)commentModel
{
    _commentModel = commentModel;
    [self.icon setHeader:commentModel.user.profile_image];
    self.name.text = commentModel.user.username;
    self.agree.text = commentModel.user.total_cmt_like_count;
    self.contenttext.text = commentModel.content;
    
    //评论者性别
    if ([commentModel.user.sex isEqualToString:Man]) {
        self.sex.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else if ([commentModel.user.sex isEqualToString:Women])
    {
        self.sex.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    //声音评论
    if (commentModel.voiceuri.length) {
        self.voiceBtn.hidden = NO;
        [self.voiceBtn setTitle:[NSString stringWithFormat:@"%zd''", commentModel.voicetime] forState:UIControlStateNormal];
        
        
    } else {
        self.voiceBtn.hidden = YES;
    }

}

//声音评论播放
- (IBAction)voiceBtnPlay:(id)sender
{
    self.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.commentModel.voiceuri]];
    [self.player play];
}

@end
