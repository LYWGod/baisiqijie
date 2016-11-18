//
//  LYWFootView.m
//  百思奇解
//
//  Created by LYW on 2016/10/23.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWFootView.h"
#import "LYWSessionManager.h"
#import "MJExtension.h"
#import "UIButton+WebCache.h"
#import "LYWSquareModel.h"
#import "LYWSquareBtn.h"
#import "LYWWebViewController.h"
#import "LYWWKViewController.h"
@interface LYWFootView()


@end


@implementation LYWFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        LYWSessionManager *manager = [LYWSessionManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"a"] = @"square";
        param[@"c"] = @"topic";
        
        [manager GET:LYW_Url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSArray *array = [LYWSquareModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self creatSquareBtn:array];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    
    }
    return self;
}


- (void)creatSquareBtn:(NSArray *)array
{
    NSInteger rowtotoal = 4;
    CGFloat btnW = LYWKscreenWidth / 4;
    CGFloat btnH = btnW;
    for (int i = 0; i < array.count; i++) {
        
        LYWSquareModel *model = array[i];
        
        LYWSquareBtn *btn = [[LYWSquareBtn alloc] init];
        btn.LYW_X = (i % rowtotoal)*btnW;
        btn.LYW_Y = (i / rowtotoal)*btnH;
        btn.LYW_W = btnW;
        btn.LYW_H = btnH;
        btn.squareModel = model;

        [btn addTarget:self action:@selector(squareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
    
    self.LYW_H = self.subviews.lastObject.LYW_bottom;
    UITableView *tabView = (UITableView *)self.superview;
    tabView.tableFooterView = self;
    [tabView reloadData];
}


- (void)squareBtnClick:(LYWSquareBtn *)btn
{
    LYWSquareModel *model = btn.squareModel;
    
    if ([model.url hasPrefix:@"http:"]) {
        LYWLog(@"跳转到网页");

        UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tab.selectedViewController;
        
        LYWWebViewController *web = [[LYWWebViewController alloc] init];
        web.url = btn.squareModel.url;
        web.titles = btn.currentTitle;
        [nav pushViewController:web animated:YES];
        
//        LYWWKViewController *web = [[LYWWKViewController alloc] init];
//        web.url = btn.squareModel.url;
//        web.title = btn.currentTitle;
//        [nav pushViewController:web animated:YES];
    }
    else if ([model.url hasPrefix:@"mod"]) {
        if ([model.url hasSuffix:@"BDJ_To_Check"]) {
            LYWLog(@"跳转到[审帖]界面");
        } else if ([model.url hasSuffix:@"BDJ_To_RecentHot"]) {
            LYWLog(@"跳转到[每日排行]界面");
        } else {
            LYWLog(@"跳转到其他界面");
        }
    }
    else
    {
        LYWLog(@"跳转到其它页面");
    }
}




@end
