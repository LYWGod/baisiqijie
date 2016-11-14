//
//  LYWComment.h
//  百思奇解
//
//  Created by LYW on 2016/11/6.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYWUser;

@interface LYWComment : NSObject

@property (nonatomic,strong) LYWUser *user;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *voiceuri;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic,copy) NSString *ID;


@end
