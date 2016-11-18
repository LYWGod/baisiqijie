//
//  LYWTopicViewController.m
//  百思奇解
//
//  Created by Leo的Mac on 16/11/10.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWTopicViewController.h"
#import "LYWSessionManager.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "LYWTopic.h"
#import "LYWRefreshHeard.h"
#import "LYWRefreshFooter.h"
#import "LYWTopicCell.h"
#import "LYWCommentController.h"


@interface LYWTopicViewController ()

@property (nonatomic,strong) NSMutableArray<LYWTopic *> *dataSource;
@property (nonatomic,weak) LYWSessionManager *manager;
@property (nonatomic,copy) NSString *maxtime;

- (NSString *)list;

@end

@implementation LYWTopicViewController

static NSString *const TopicCellId = @"LYWTopicCell";

- (topictype)type
{
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self getrefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYWTopicCell class]) bundle:nil] forCellReuseIdentifier:TopicCellId];
}


/**
 *  上下拉刷新控件
 */
- (void)getrefresh
{
    self.tableView.backgroundColor = LYWCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [LYWRefreshHeard headerWithRefreshingTarget:self refreshingAction:@selector(getNetdata)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [LYWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
}

/**
 *  加载最新数据
 */
- (void)getNetdata
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.list;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYW_Url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        _maxtime = responseObject[@"info"][@"maxtime"];
        weakSelf.dataSource = [LYWTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

/**
 *   加载更多数据
 */
- (void)loadMore
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.list;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = _maxtime;
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYW_Url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        _maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *array = [LYWTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.dataSource addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellId];
    cell.topicModel = self.dataSource[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = self.dataSource[indexPath.row].cellHeight;
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYWCommentController *comment = [[LYWCommentController alloc] init];
    comment.topicModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:comment animated:YES];
}

/**
 *  数据源懒加载
 */
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

/**
 *  请求对象懒加载
 */
- (LYWSessionManager *)manager
{
    if (!_manager) {
        self.manager = [LYWSessionManager manager];
    }
    return _manager;
}

- (NSString *)list
{
    if ([self.parentViewController isKindOfClass:NSClassFromString(@"LYWNewpostController")]) return @"newlist";
    return @"list";
}



@end
