//
//  UIView+LYWExtension.h
//  百思奇解
//
//  Created by LYW on 2016/10/15.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LYWExtension)


@property (nonatomic,assign) CGFloat LYW_X;
@property (nonatomic,assign) CGFloat LYW_Y;
@property (nonatomic,assign) CGFloat LYW_W;
@property (nonatomic,assign) CGFloat LYW_H;
@property (nonatomic,assign) CGSize  LYW_size;
@property (nonatomic,assign) CGPoint LYW_point;
@property (assign, nonatomic) CGFloat LYW_centerX;
@property (assign, nonatomic) CGFloat LYW_centerY;
@property (nonatomic,assign) CGFloat LYW_right;
@property (nonatomic,assign) CGFloat LYW_bottom;

+(instancetype)LYWviewFromXib;

@end
