//
//  LYWNewpostController.m
//  百思奇解
//
//  Created by LYW on 2016/10/15.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWNewpostController.h"
#import "LYWRecommendController.h"
@interface LYWNewpostController ()

@end

@implementation LYWNewpostController

- (void)viewDidLoad {
    [super viewDidLoad];

    LYWLogFunc
    self.view.backgroundColor = LYWRandomColor;


    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(MainTagSubIconClick)];
    
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"小蓝" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnItemClick)];
    [rightButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}


- (void)MainTagSubIconClick
{
    LYWRecommendController *recommend = [[LYWRecommendController alloc] init];
    [self.navigationController pushViewController:recommend animated:YES];
}

- (void)rightBtnItemClick
{
    LYWLog(@"😁");
}

@end
