//
//  LYWAttentionController.m
//  百思奇解
//
//  Created by LYW on 2016/10/15.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWAttentionController.h"
#import "LYWRecommendViewController.h"
#import "LYWLoginOrRegistViewController.h"
@interface LYWAttentionController ()

@end

@implementation LYWAttentionController

- (void)viewDidLoad {
    [super viewDidLoad];

     LYWLogFunc
    self.view.backgroundColor = LYWRandomColor;
   
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(MainTagSubIconClick)];
    
    
}

- (void)MainTagSubIconClick
{
    LYWRecommendViewController *recommend = [[LYWRecommendViewController alloc] init];
    [self.navigationController  pushViewController:recommend animated:YES];
}

- (IBAction)loginOrRegist
{
    LYWLoginOrRegistViewController *loginOrRegist = [[LYWLoginOrRegistViewController alloc] init];
    [self presentViewController:loginOrRegist animated:YES completion:nil];;
}

@end
