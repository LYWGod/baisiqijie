//
//  LYWTopicVoice.m
//  百思奇解
//
//  Created by LYW on 2016/11/6.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWTopicVoice.h"
#import "LYWTopic.h"
#import "UIImageView+WebCache.h"
#import "LYWTimeTool.h"
#import <AVFoundation/AVFoundation.h>


@interface LYWTopicVoice()

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *playcountlab;
@property (weak, nonatomic) IBOutlet UILabel *timelab;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

/** 上一个按钮 */
@property (weak, nonatomic) UIButton *lastPlayButton;

/** 播放声音的播放器 */
@property (nonatomic,strong) AVPlayer *player;

@end


@implementation LYWTopicVoice

static AVPlayer *player_;
static UIButton *lastPlayButton_;
static LYWTopic *lastTopic_;

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setTopicModel:(LYWTopic *)topicModel
{
    _topicModel = topicModel;
    //背景图
    [self.picture sd_setImageWithURL:[NSURL URLWithString:topicModel.image1] placeholderImage:nil];
    //时间
    self.timelab.text = [LYWTimeTool getFormatTimeWithTimeInterval:topicModel.voicetime];
    //播放数量
    if (self.topicModel.playcount > 10000) {
        self.playcountlab.text = [NSString stringWithFormat:@"%.1f万播放",self.topicModel.playcount/1000.0];
    }else{
        self.playcountlab.text = [NSString stringWithFormat:@"%zd播放",self.topicModel.playcount];
    }
    //暂停 or 播放
    [self.playButton setImage:[UIImage imageNamed:topicModel.voicePlaying ? @"playButtonPause":@"playButtonPlay"] forState:UIControlStateNormal];
    
}

- (IBAction)play:(UIButton *)playButton
{
    //音频播放存在问题
//    playButton.selected = !playButton.isSelected;
//    lastPlayButton_.selected = !lastPlayButton_.isSelected;
//    if (lastTopic_ != self.topicModel) {
//        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topicModel.voiceuri]];
//        
//        [player_ replaceCurrentItemWithPlayerItem:playerItem];
//        [player_ play];
//        lastTopic_.voicePlaying = NO;
//        self.topicModel.voicePlaying = YES;
//        
//        [lastPlayButton_ setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
//        [playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
//        
//    }else{
//        if(lastTopic_.voicePlaying){
//            [player_ pause];
//            self.topicModel.voicePlaying = NO;
//            [playButton setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
//        }else{
//            [player_ play];
//            self.topicModel.voicePlaying = YES;
//            [playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
//        }
//    }
//    lastTopic_ = self.topicModel;
//    lastPlayButton_ = playButton;

}


@end
