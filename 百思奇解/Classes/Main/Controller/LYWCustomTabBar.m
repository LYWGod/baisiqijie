//
//  LYWCustomTabBar.m
//  百思奇解
//
//  Created by LYW on 2016/10/15.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWCustomTabBar.h"
#import "LYWCustomNavController.h"

#import "LYWEssenceController.h"
#import "LYWNewpostController.h"
#import "LYWAttentionController.h"
#import "LYWMineController.h"

#import "LYWTabBar.h"

@interface LYWCustomTabBar ()
//@property (nonatomic,weak) UIButton *publishBtn;

@end

@implementation LYWCustomTabBar


//- (UIButton *)publishBtn
//{
//    if (!_publishBtn) {
//        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        publishBtn.frame = CGRectMake(0, 0, self.tabBar.frame.size.width /5, self.tabBar.frame.size.height);
//        publishBtn.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
//        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
//        [publishBtn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:publishBtn];
//        _publishBtn = publishBtn;
//
//    }
//    return _publishBtn;
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    [self publishBtn];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
    
    [self setupChildController:[[LYWEssenceController alloc] init] title:@"精华" image:@"tabBar_new_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildController:[[LYWNewpostController alloc] init] title:@"最新" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    
//    [self setupChildController:[[UIViewController alloc] init] title:@"" image:@"" selectedImage:@""];
    
    [self setupChildController:[[LYWAttentionController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildController: [[LYWMineController alloc] init] title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[LYWTabBar alloc] init] forKey:@"tabBar"];
}

- (void)setupChildController:(UIViewController *)control title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    control.title = title;
    if (image.length) {
        control.tabBarItem.image = [UIImage imageNamed:image];
        control.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    LYWCustomNavController *nav = [[LYWCustomNavController alloc] initWithRootViewController:control];
    [self addChildViewController:nav];
}

//- (void)publishBtnClick
//{
//    LYWLogFunc;
//}

@end
