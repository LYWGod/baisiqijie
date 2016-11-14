//
//  LYWCommentController.m
//  百思奇解
//
//  Created by LYW on 2016/11/13.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWCommentController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "LYWTopic.h"
#import "LYWComment.h"
#import "LYWUser.h"
#import "LYWRefreshHeard.h"
#import "LYWRefreshFooter.h"
#import "LYWCommentCell.h"
#import "LYWTopicCell.h"

@interface LYWCommentController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint;

@property (nonatomic,strong) NSMutableArray *commentsArr;

@property (nonatomic,strong) NSMutableArray *hotCommentArr;

@property (nonatomic,strong) AFHTTPSessionManager *manager;


@end

@implementation LYWCommentController
static NSString * const commentID = @"LYWCommentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听键盘的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setupTableView];
    [self setupTableViewHeard];
    [self setupRefresh];
}

- (void)setupTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = LYWCommonBgColor;
    //添加一个手势点击屏幕时候，让键盘下去
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.tableView addGestureRecognizer:tap];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYWCommentCell class]) bundle:nil] forCellReuseIdentifier:commentID];
    //自动计算高度
    self.tableView.estimatedRowHeight = 1000;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

/**
 设置评论的头
 */
- (void)setupTableViewHeard
{    //这里要给cell添加一个父控件，为了不让cell高度减少
    UIView *view = [[UIView alloc] init];

    LYWTopicCell *cell = [LYWTopicCell LYWviewFromXib];
    cell.topicModel = self.topicModel;
    cell.frame = CGRectMake(0, 0, LYWKscreenWidth, self.topicModel.cellHeight);
    [view addSubview:cell];
    //这个父控件的高度就等于cell的高度
    view.LYW_H = self.topicModel.cellHeight + LYWMargin;
    
    self.tableView.tableHeaderView = view;
}

/**
 设置上下拉刷新
 */
- (void)setupRefresh
{
    self.tableView.mj_header = [LYWRefreshHeard headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [LYWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

/**
 最新数据
 */
- (void)loadNewData
{
    //取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.ID;
    params[@"hot"] = @1;
 
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYW_Url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 没有任何评论数据 服务器在没有数据返回时候，给的是一个数组而不是字典
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 让[刷新控件]结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        
        // 最热评论模型数组
        weakSelf.hotCommentArr = [LYWComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //评论模型数组
        weakSelf.commentsArr = [LYWComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        //判断是否加载完了所有的评论数据
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.commentsArr.count == total) { // 全部加载完毕
            // 提示用户加载完了全部
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}


/**
 更多数据
 */
- (void)loadMoreData
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.ID;
    params[@"lastcid"] = [self.commentsArr.lastObject ID];
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYW_Url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 没有任何评论数据 服务器在没有数据返回时候，给的是一个数组而不是字典
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [weakSelf.tableView.mj_footer endRefreshing];
            return;
        }
        
        NSArray *arr = [LYWComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.commentsArr addObjectsFromArray:arr];
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.commentsArr.count == total) { // 全部加载完毕
            // 提示用户:没有更多数据
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        } else { // 还没有加载完全
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.hotCommentArr.count) return 2;
    if (self.commentsArr.count) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.hotCommentArr.count) return self.hotCommentArr.count;

    return self.commentsArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID];
    
    if (indexPath.section == 0 && self.hotCommentArr.count) {
        cell.commentModel = self.hotCommentArr[indexPath.row];
    } else {
        cell.commentModel = self.commentsArr[indexPath.row];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 第0组 && 有最热评论数据
    if (section == 0 && self.hotCommentArr.count) {
        return  @"最热评论";
    } else { // 其他情况
        return @"最新评论";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyHeight = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y;
    CGFloat ScreenHeigh = LYWKscreenHeight;
    self.layoutConstraint.constant = ScreenHeigh - keyHeight;
    [UIView animateWithDuration:time animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 评论数组懒加载
 @return 评论数组
 */
- (NSMutableArray *)commentsArr
{
    if (!_commentsArr) {
        self.commentsArr = [NSMutableArray array];
    }
    return _commentsArr;
}

/**
 最热评论懒加载
 @return 最热评论数组
 */
- (NSMutableArray *)hotCommentArr
{
    if (!_hotCommentArr) {
        self.hotCommentArr = [NSMutableArray array];
    }
    return _hotCommentArr;
}

/**
 网络请求管理者
 @return 请求管理者
 */
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

//手势监听让键盘掉下去
- (void)tapClick
{
    [self.view endEditing:YES];
}

/**
 *  当用户开始拖拽scrollView就会调用一次
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}





@end
