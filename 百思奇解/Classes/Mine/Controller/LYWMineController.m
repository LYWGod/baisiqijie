//
//  LYWMineController.m
//  百思奇解
//
//  Created by LYW on 2016/10/15.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWMineController.h"
#import "LYWSettingViewController.h"
#import "LYWMeTableViewCell.h"
#import "LYWFootView.h"

@interface LYWMineController ()

@end

@implementation LYWMineController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *itembtn = [UIBarButtonItem itemWithimage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(MainTagSubIconClick)];
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithimage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonItemClick)];
    
    self.navigationItem.rightBarButtonItems = @[item,itembtn];
    [self setupTableView];
    
}


- (void)MainTagSubIconClick
{
    LYWLogFunc
}

- (void)settingButtonItemClick
{
    LYWSettingViewController *setting = [[LYWSettingViewController alloc] init];
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = LYWCommonBgColor;
    self.tableView.sectionFooterHeight = LYWSmallMargin * 0.1;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    self.tableView.tableFooterView = [[LYWFootView alloc] initWithFrame:CGRectMake(0, 0,LYWKscreenWidth , 500)];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    LYWMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LYWMeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }
    else
    {
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
