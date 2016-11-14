//
//  LYWRecommendController.m
//  百思奇解
//
//  Created by LYW on 2016/11/5.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWRecommendController.h"
#import "LYWRecommend.h"
#import "LYWRecommendCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
@interface LYWRecommendController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,weak) AFHTTPSessionManager *manager;

@end


@implementation LYWRecommendController
static  NSString *const RecommendCell = @"LYWRecommendCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐标签";

    [self setupTableView];
    [self getNetdata];
}

- (void)getNetdata
{
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYW_Url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        _dataSource = [LYWRecommend mj_objectArrayWithKeyValuesArray:responseObject];
        [weakSelf.tableView reloadData];
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
    

}


- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYWRecommendCell class]) bundle:nil] forCellReuseIdentifier:RecommendCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYWRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendCell];
    
    cell.model = _dataSource[indexPath.row];
    
    return cell;
}


-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

/// 界面消失的时候调用
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 1.取消所有任务
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 2.移除会话管理者 invalidateSessionCancelingTasks:是否需要任务完成后再取消，这里填NO
    [self.manager invalidateSessionCancelingTasks:NO];
    
    // 3.取消指示器
    [SVProgressHUD dismiss];
}

@end
