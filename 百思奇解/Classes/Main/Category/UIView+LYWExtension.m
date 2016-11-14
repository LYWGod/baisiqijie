//
//  UIView+LYWExtension.m
//  百思奇解
//
//  Created by LYW on 2016/10/15.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "UIView+LYWExtension.h"

@implementation UIView (LYWExtension)

-(void)setLYW_X:(CGFloat)LYW_X
{
    CGRect frame = self.frame;
    frame.origin.x = LYW_X;
    self.frame = frame;
}

- (CGFloat)LYW_X
{
    return self.frame.origin.x;
}

- (void)setLYW_Y:(CGFloat)LYW_Y
{
    CGRect frame = self.frame;
    frame.origin.y = LYW_Y;
    self.frame = frame;
}

- (CGFloat)LYW_Y
{
    return self.frame.origin.y;
}

- (void)setLYW_W:(CGFloat)LYW_W
{
    CGRect frame = self.frame;
    frame.size.width = LYW_W;
    self.frame = frame;
}

- (CGFloat)LYW_W
{
    return self.frame.size.width;
}


- (void)setLYW_H:(CGFloat)LYW_H
{
    CGRect frame = self.frame;
    frame.size.height = LYW_H;
    self.frame = frame;
}

-(CGFloat)LYW_H
{
    return self.frame.size.height;
}

- (void)setLYW_size:(CGSize)LYW_size
{
    CGRect frame = self.frame;
    frame.size = LYW_size;
    self.frame = frame;
}

- (CGSize)LYW_size
{
    return  self.frame.size;
}

-(void)setLYW_point:(CGPoint)LYW_point
{
    CGRect frame = self.frame;
    frame.origin = LYW_point;
    self.frame = frame;
}

- (CGPoint)LYW_point
{
    return self.frame.origin;
}


- (void)setLYW_centerX:(CGFloat)LYW_centerX
{
    CGPoint center = self.center;
    center.x = LYW_centerX;
    self.center = center;
}

- (void)setLYW_centerY:(CGFloat)LYW_centerY
{
    CGPoint center = self.center;
    center.y = LYW_centerY;
    self.center = center;
}

- (CGFloat)LYW_centerX
{
    return self.center.x;
}

- (CGFloat)LYW_centerY
{
    return self.center.y;
}


- (CGFloat)LYW_right
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)LYW_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setLYW_right:(CGFloat)LYW_right
{
    self.LYW_X = LYW_right - self.LYW_W;
}

- (void)setLYW_bottom:(CGFloat)LYW_bottom
{
    self.LYW_Y = LYW_bottom - self.LYW_H;
}



+(instancetype)LYWviewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}




@end
