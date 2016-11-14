//
//  LYWSettingViewController.m
//  百思奇解
//
//  Created by LYW on 2016/10/16.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWSettingViewController.h"
#import "LYWCacheCell.h"
@interface LYWSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;


@end

@implementation LYWSettingViewController

static NSString *const CacheCell = @"LYWCacheCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[LYWCacheCell class] forCellReuseIdentifier:CacheCell];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYWCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:CacheCell];

    return cell;
}





@end
