//
//  LYWTopicImage.m
//  百思奇解
//
//  Created by LYW on 2016/11/6.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWTopicImage.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "LYWTopic.h"
#import "LYWSeeBIgPictureController.h"
@interface LYWTopicImage()
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIImageView *isgifImage;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageBtn;


@end


@implementation LYWTopicImage

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    //进度条的一些设置
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor grayColor];
    self.progressView.trackTintColor = [UIColor grayColor];
    //给图片添加手势查看大图
    self.picture.userInteractionEnabled = YES;
    [self.picture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}


-(void)setTopicModel:(LYWTopic *)topicModel
{
    _topicModel = topicModel;

    //图片
    [self.picture sd_setImageWithURL:[NSURL URLWithString:topicModel.image0] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
       
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        
        self.progressView.progress = progress;
        self.progressView.hidden = NO;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
         }];
    
    //动态图
    self.isgifImage.hidden = !topicModel.is_gif;
    

    // 查看大图
    if (topicModel.is_big) {
        self.picture.contentMode = UIViewContentModeTop;
        self.picture.clipsToBounds = YES;
        self.seeBigImageBtn.hidden = NO;
    }else
    {
        self.picture.contentMode = UIViewContentModeScaleAspectFill;
        self.picture.clipsToBounds = NO;
        self.seeBigImageBtn.hidden = YES;
    }

}

//点击查看大图按钮
- (IBAction)seebigImageBtnClick:(UIButton *)sender
{
    [self seeBigPicture];
}

//点击图片查看大图
-(void)seeBigPicture
{
    LYWSeeBIgPictureController *seeBigPicture = [[LYWSeeBIgPictureController alloc] init];
    seeBigPicture.topicModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigPicture animated:YES completion:nil];
}

@end
