//
//  LYWPublishViewController.m
//  百思奇解
//
//  Created by Leo的Mac on 16/11/11.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWPublishViewController.h"
#import "LYWPublishBtn.h"

#import <POP.h>

/**  每一行的列数 */
#define LYWCol 3

/**  有关弹性的系数 */
#define LYWspring 10

@interface LYWPublishViewController ()

/** 时间数组 */
@property (nonatomic,strong) NSArray *times;
/** 按钮数组 */
@property (nonatomic,strong) NSMutableArray *buttons;

/** 标语 */
@property (nonatomic,weak) UIImageView *sloganView;


@end

@implementation LYWPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //标语
    [self addSloganView];
    //添加按钮
    [self addBtn];
}

- (void)addSloganView
{
    CGFloat sloganY = LYWKscreenHeight * 0.20;
    //标题
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.LYW_Y = sloganY - LYWKscreenHeight;
    sloganView.LYW_centerX = LYWKscreenWidth * 0.5;
    [self.view addSubview:sloganView];
    _sloganView = sloganView;
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    springAnimation.fromValue  = @(sloganY - LYWKscreenHeight);
    springAnimation.toValue = @(sloganY);
    springAnimation.springBounciness = LYWspring;
    springAnimation.springSpeed = LYWspring;
    springAnimation.beginTime = CACurrentMediaTime() + [[self.times lastObject] doubleValue];
    //给标题添加动画
    [sloganView.layer pop_addAnimation:springAnimation forKey:nil];
}

//添加按钮
- (void)addBtn
{
    NSArray *imageArr = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titleArr = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
 
    CGFloat publishW = LYWKscreenWidth / 3;
    CGFloat publishH = publishW;
    
    for (NSInteger  i = 0; i < imageArr.count; i++) {

        LYWPublishBtn *publishBtn = [[LYWPublishBtn alloc] init];
        publishBtn.LYW_X = (i % LYWCol)*publishW;
        publishBtn.LYW_Y = (i / LYWCol)*publishH + 200;
        publishBtn.LYW_W = publishW;
        publishBtn.LYW_H = publishH;
        [publishBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:publishBtn];
        
        // 把耗时操作放在子线程中
        dispatch_async(dispatch_get_main_queue(), ^{
            /// 添加弹簧动画
            // 1.创建弹簧动画
            POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            
            // 2.设置弹簧的fromValue 和 toValue
            springAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(publishBtn.LYW_X, publishBtn.LYW_Y -LYWKscreenHeight, publishW, publishH)];
            springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(publishBtn.LYW_X, publishBtn.LYW_Y, publishW, publishH)];
            
            // 3.设置弹性速度 和 弹性系数
            springAnimation.springBounciness = LYWspring;
            springAnimation.springSpeed = LYWspring;
            
            // 4.CACurrentMediaTime() 取得当前时间
            springAnimation.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
            
            // 5.给按钮添加动画
            [publishBtn pop_addAnimation:springAnimation forKey:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 6.允许用户交互
                self.view.userInteractionEnabled = YES;
            });
        });

        
    }
    
}

#pragma mark ========= 操作 方法 ==========
/** 退出动画方法的封装 */
- (void)exitWithBolock:(void(^)())oparation{
    /// 0.禁止用户交互
    self.view.userInteractionEnabled = NO;
    
    /// 1.开启子线程
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        NSInteger count = self.buttons.count;
        
        // 0.取得每一个按钮 (遍历)
        for (int i = 0; i < count; i++) {
            LYWPublishBtn *btn = self.buttons[i];
            // 1.创建按钮弹簧动画
            POPBasicAnimation *btnAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
            // 2.设置弹簧的toValue
            btnAnimation.toValue = @(btn.LYW_Y + LYWKscreenHeight);
            // 3.CACurrentMediaTime() 取得当前时间
            btnAnimation.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
            // 4.给按钮添加动画
            [btn.layer pop_addAnimation:btnAnimation forKey:nil];
            
            /// 缩放动画
            /*
             POPBasicAnimation *btnAnimation1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
             // 2.设置弹簧的toValue
             btnAnimation1.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
             // 3.CACurrentMediaTime() 取得当前时间
             btnAnimation1.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
             // 4.给按钮添加动画
             [btn.layer pop_addAnimation:btnAnimation1 forKey:nil]; */
        }
        
        // 1.创建标语弹簧动画
        POPBasicAnimation *sloganAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        // 2.设置弹簧的toValue
        sloganAnimation.toValue = @(self.sloganView.LYW_Y + LYWKscreenHeight);
        // 3.CACurrentMediaTime() 取得当前时间
        sloganAnimation.beginTime = CACurrentMediaTime() + [[self.times lastObject] doubleValue];
        // 4.给按钮添加动画
        [self.sloganView.layer pop_addAnimation:sloganAnimation forKey:nil];
        
        // 动画执行完之后
        [sloganAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            /// 回到主线程
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                // 退出当前控制器
                [self dismissViewControllerAnimated:NO completion:nil];
                // 判断有木有其他操作
                if(oparation){
                    oparation();
                }
            }];
        }];
    }];
    
}


- (void)publishBtnClick
{
    LYWLogFunc
}

//取消按钮点击
- (IBAction)shareButtonCancel:(id)sender
{
     [self exitWithBolock:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击屏
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self exitWithBolock:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (NSArray *)times{
    if (!_times) {
        _times = [NSArray array];
        CGFloat interVal = 0.01;
        _times = @[ @(4*interVal), @(5*interVal),@(6*interVal),@(3*interVal),@(2*interVal),@(1*interVal),@(7*interVal)];
    }
    return _times;
}


@end
