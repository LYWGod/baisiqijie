//
//  LYWTopic.h
//  百思奇解
//
//  Created by LYW on 2016/11/5.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYWComment;

typedef NS_ENUM(NSInteger, topictype) {
    topictypeAll = 1,        // 全部
    topictypePicture = 10,   // 图片
    topictypeVoice = 31,     // 声音
    topictypeWord = 29,      // 段子
    topictypeVideo = 41      // 视频
};

@interface LYWTopic : NSObject

@property (nonatomic,copy) NSString *ID;
/** 昵称 */
@property (nonatomic,copy) NSString *name;
/** 头像 */
@property (nonatomic,copy) NSString *profile_image;
/** 顶 */
@property (nonatomic,copy) NSString *ding;
/** 转发数 */
@property (nonatomic,copy) NSString *repost;
/** 评论数 */
@property (nonatomic,copy) NSString *comment;
/** 踩 */
@property (nonatomic,copy) NSString *hate;
/** 正文 */
@property (nonatomic,copy) NSString *text;
/** 发帖时间 */
@property (nonatomic,copy) NSString *create_time;
/** 喜欢 */
@property (nonatomic,copy) NSString *favourite;
/** 最热评论 */
@property (nonatomic, strong) NSArray<LYWComment *> *top_cmt;
/** 视频或音频宽度 */
@property (nonatomic,assign) CGFloat width;
/** 视频或音频高度 */
@property (nonatomic,assign) CGFloat height;

/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** 如果为音频则为音频的时长 */
@property (nonatomic,copy) NSString *voicelength;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 如果为音频，则为音频的播放地址 */
@property (nonatomic,copy) NSString *voiceuri;

/** 如果含有视频则该参数为视频的长度 */
//@property (nonatomic,copy) NSString *videotime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频播放的url地址 */
@property (nonatomic,copy) NSString *videouri;
/** 页面中的视频图片的url */
@property (nonatomic,copy) NSString *image1;
/** 视频加载时候的静态显示的图片地址 */
@property (nonatomic,copy) NSString *cdn_img;


@property (nonatomic,copy) NSString *image0;
@property (nonatomic,copy) NSString *image2;

/** 是否是gif动画 */
@property (nonatomic,assign) BOOL is_gif;

/** 帖子类型 */
@property (nonatomic, assign) topictype type;

/** cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic,assign) CGRect contentF;
/** 是否是gif动画 */
@property (nonatomic,assign) BOOL is_big;

@property (nonatomic, assign,getter=is_voicePlaying) BOOL voicePlaying;




@end
