//
//  LYWTopicCell.m
//  百思奇解
//
//  Created by LYW on 2016/11/5.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWTopicCell.h"
#import "LYWTopic.h"
#import "LYWComment.h"
#import "LYWUser.h"
#import "LYWTopicImage.h"
#import "LYWTopicVoice.h"
#import "LYWTopicVideo.h"

@interface LYWTopicCell()

@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *text_Lab;
@property (weak, nonatomic) IBOutlet UIView *fatherView;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhuanBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;

@property (nonatomic,weak) LYWTopicImage *TopicImageView;
@property (nonatomic,copy) LYWTopicVoice *TopicVoiceView;
@property (nonatomic,weak) LYWTopicVideo *TopicVideoView;

@end


@implementation LYWTopicCell

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= LYWMargin;
    frame.origin.y += LYWMargin;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
     self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopicModel:(LYWTopic *)topicModel
{
    _topicModel = topicModel;
    // 头像
    [self.profile_image setHeader:topicModel.profile_image];
    //昵称
    self.name_lab.text = topicModel.name;
    // 内容
    self.text_Lab.text = topicModel.text;
    //创建时间
    self.timeLab.text = topicModel.create_time;
    
    //中间内容
    if(topicModel.type == topictypePicture)
    {
        self.TopicImageView.hidden = NO;
        self.TopicImageView.frame = topicModel.contentF;
        self.TopicImageView.topicModel = topicModel;
        self.TopicVoiceView.hidden = YES;
        self.TopicVideoView.hidden = YES;
    }
    else if (topicModel.type == topictypeVoice)
    {
        self.TopicVoiceView.hidden = NO;
        self.TopicVoiceView.frame = topicModel.contentF;
        self.TopicVoiceView.topicModel = topicModel;
        self.TopicImageView.hidden = YES;
        self.TopicVideoView.hidden = YES;
    }else if (topicModel.type == topictypeVideo)
    {
        self.TopicVideoView.hidden = NO;
        self.TopicVideoView.frame = topicModel.contentF;
        self.TopicVideoView.topicModel = topicModel;
        self.TopicImageView.hidden = YES;
        self.TopicVoiceView.hidden = YES;
    }else if (topicModel.type == topictypeWord)
    {
        self.TopicImageView.hidden = YES;
        self.TopicVideoView.hidden = YES;
        self.TopicVoiceView.hidden = YES;
    }
    
    //最热评论
    LYWComment *comment = topicModel.top_cmt.firstObject;
    if (comment) { // 有最热评论
        self.fatherView.hidden = NO;
        NSString *username = comment.user.username; // 用户名
        NSString *content = comment.content; // 评论内容
        self.commentLab.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else { // 没有最热评论
        self.fatherView.hidden = YES;
    }
    
    //工具条
    [self setTitle:topicModel.ding button:self.dingBtn placeHolder:@"顶"];
    [self setTitle:topicModel.hate button:self.caiBtn placeHolder:@"踩"];
    [self setTitle:topicModel.repost button:self.zhuanBtn placeHolder:@"转发"];
    [self setTitle:topicModel.comment button:self.commentBtn placeHolder: @"评论"];

    
}

- (void)setTitle:(NSString *)number button:(UIButton *)button placeHolder:(NSString *)placeHolder
{
    NSInteger count = [number integerValue];
    if (count >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%ld万",count/10000] forState:UIControlStateNormal];
    }else if (number > 0)
    {
        [button setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    }else
    {
        [button setTitle:placeHolder forState:UIControlStateNormal];
    }
}

- (IBAction)moreBtnClick:(UIButton *)sender
{
    UIAlertController *alertSheet =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertSheet addAction:actionOne];
    [alertSheet addAction:actionTwo];
    [alertSheet addAction:cancel];
    
    [self.window.rootViewController presentViewController:alertSheet animated:YES completion:nil];
}


- (LYWTopicImage *)TopicImageView
{
    if (!_TopicImageView) {
     LYWTopicImage *TopicImageView = [LYWTopicImage LYWviewFromXib];
        [self.contentView addSubview:TopicImageView];
        _TopicImageView = TopicImageView;
    }
    return _TopicImageView;
}

- (LYWTopicVideo *)TopicVideoView
{
    if (!_TopicVideoView) {
        LYWTopicVideo *TopicVideoView = [LYWTopicVideo LYWviewFromXib];
        [self.contentView addSubview:TopicVideoView];
        _TopicVideoView = TopicVideoView;
    }
    return _TopicVideoView;
}

- (LYWTopicVoice *)TopicVoiceView
{
    if (!_TopicVoiceView) {
     LYWTopicVoice *TopicVoiceView = [LYWTopicVoice LYWviewFromXib];
        [self.contentView addSubview:TopicVoiceView];
        _TopicVoiceView = TopicVoiceView;
    }
    return _TopicVoiceView;
}




@end
