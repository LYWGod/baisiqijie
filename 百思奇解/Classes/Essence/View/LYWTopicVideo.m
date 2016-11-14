//
//  LYWTopicVideo.m
//  百思奇解
//
//  Created by LYW on 2016/11/6.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWTopicVideo.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LYWTopic.h"
#import "LYWTimeTool.h"

@interface LYWTopicVideo()

@property (weak, nonatomic) IBOutlet UIImageView *Picture;
@property (weak, nonatomic) IBOutlet UILabel *playcountlab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation LYWTopicVideo

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopicModel:(LYWTopic *)topicModel
{
    _topicModel = topicModel;
    [self.Picture sd_setImageWithURL:[NSURL URLWithString:topicModel.image1] placeholderImage:nil];
   
    self.timeLab.text = [LYWTimeTool getFormatTimeWithTimeInterval:topicModel.videotime];
  
    self.playcountlab.text = [NSString stringWithFormat:@"%zd播放",topicModel.playcount];
    
}

- (IBAction)play:(UIButton *)sender
{
    //iOS9之前的做法
    MPMoviePlayerViewController *movieVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.topicModel.videouri]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:movieVC];
}




@end
