//
//  LYWEssenceController.m
//  百思奇解
//
//  Created by LYW on 2016/10/15.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWEssenceController.h"

#import "LYWAllViewController.h"
#import "LYWVideoViewController.h"
#import "LYWVoiceViewController.h"
#import "LYWPictureViewController.h"
#import "LYWWordViewController.h"
#import "LYWtitleBtn.h"
#import "LYWRecommendController.h"
@interface LYWEssenceController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic,weak) UIView *titleView;

@property (nonatomic,weak) UIButton *selectdBtn;

@property (nonatomic,weak) UIView *Indicate;

@end

@implementation LYWEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self addChildVC];
    
    [self setupScrollView];
    
    [self setuptitleView];
    
    [self addChildrenView];
}

- (void)setupNav
{
    self.view.backgroundColor = LYWCommonBgColor;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(MainTagSubIconClick)];
}

- (void)MainTagSubIconClick
{
    LYWRecommendController *recommend = [[LYWRecommendController alloc] init];
    [self.navigationController pushViewController:recommend animated:YES];
}

- (void)addChildVC
{
    LYWAllViewController *all = [[LYWAllViewController alloc] init];
    [self addChildViewController:all];
    
    LYWVideoViewController *video = [[LYWVideoViewController alloc] init];
    [self addChildViewController:video];
    
    LYWVoiceViewController *voice = [[LYWVoiceViewController alloc] init];
    [self addChildViewController:voice];
   
    LYWPictureViewController *picture = [[LYWPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    LYWWordViewController *word = [[LYWWordViewController alloc] init];
    [self addChildViewController:word];
}

- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * LYWKscreenWidth, 0);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

- (void)setuptitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    titleView.LYW_X = 0;
    titleView.LYW_Y = 64;
    titleView.LYW_W = LYWKscreenWidth;
    titleView.LYW_H = 35;
    [self.view addSubview:titleView];
    _titleView = titleView;
    
    NSArray *titleArr = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat btnW = LYWKscreenWidth / titleArr.count;
    CGFloat btnH = titleView.LYW_H;
    
    for (NSInteger i = 0; i < titleArr.count; i++) {
       
        LYWtitleBtn *btn = [[LYWtitleBtn alloc] init];
        btn.tag = i;
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
    }
    
    UIButton *btn = titleView.subviews.firstObject;

    UIView *Indicate = [[UIView alloc] init];
    Indicate.LYW_H = 2;
    Indicate.LYW_Y = titleView.LYW_H - Indicate.LYW_H;
    Indicate.LYW_W = btn.titleLabel.LYW_W;
    Indicate.backgroundColor = [btn titleColorForState:UIControlStateSelected];
    [titleView addSubview:Indicate];
    _Indicate = Indicate;
    
    // 立刻根据文字内容计算label的宽度
    [btn.titleLabel sizeToFit];
    Indicate.LYW_W = btn.titleLabel.LYW_W;
    Indicate.LYW_centerX = btn.LYW_centerX;
    // 默认情况 : 选中最前面的标题按钮
    btn.selected = YES;
    self.selectdBtn = btn;
}

- (void)btnclick:(UIButton *)clickedBtn
{
    self.selectdBtn.selected = NO;
    self.selectdBtn = clickedBtn;
    self.selectdBtn.selected = YES;
    
    // 指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.Indicate.LYW_W = clickedBtn.titleLabel.LYW_W;
        self.Indicate.LYW_centerX = clickedBtn.LYW_centerX;
    }];
    
    CGPoint offest = _scrollView.contentOffset;
    offest.x = clickedBtn.tag * LYWKscreenWidth;
    [_scrollView setContentOffset:offest animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self addChildrenView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / LYWKscreenWidth;
    UIButton *btn = _titleView.subviews[index];
    [self btnclick:btn];
    
    [self addChildrenView];

}

- (void)addChildrenView
{
    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / LYWKscreenWidth;
    
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];

    if ([childVc isViewLoaded]) return;

    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
    
}





@end
