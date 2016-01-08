//
//  WJNewsCommonViewController.m
//  漳州公积金
//
//  Created by fengwujie on 16/1/6.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJNewsCommonViewController.h"
#import "WJLoadMoreFooter.h"
#import "WJNews.h"
#import "WJNewsCommonCell.h"
#import "WJWebViewController.h"
#import "WJNewsParam.h"
#import "WJNewsReturn.h"
#import "WJNewsTool.h"

@interface WJNewsCommonViewController ()
/**
 *  新闻数组
 */
@property (nonatomic, strong) NSMutableArray *arrayNews;
/**
 *  上拉时tableView的刷新控件
 */
@property (nonatomic, weak) UIRefreshControl *refreshControl;
/**
 *  下拉加载更多时的刷新控件
 */
@property (nonatomic, weak) WJLoadMoreFooter *footer;
@end

@implementation WJNewsCommonViewController

#pragma mark - 初始化
- (NSMutableArray *)arrayNews
{
    if (_arrayNews == nil) {
        _arrayNews = [NSMutableArray array];
    }
    return _arrayNews;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = WJGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    
    // 2.监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    // 4.加载数据
    [self refreshControlStateChange:refreshControl];
    
    // 5.添加上拉加载更多控件
    WJLoadMoreFooter *footer = [WJLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
}

/**
 *  当下拉刷新控件进入刷新状态（转圈圈）的时候会自动调用
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    [self loadNewStatuses:refreshControl];
}


/**
 *  加载最新的微博数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    // 1.封装请求参数
    WJNewsParam *param = [WJNewsParam param];
    WJNews *news = [self.arrayNews firstObject];
    if (news) {
        param.since_id = @([news.strID longLongValue]);
    }
    
    // 2.加载微博数据
    [WJNewsTool newsWithParam:param success:^(WJNewsReturn *result) {
        // 获得最新的微博frame数组
        NSArray *newss = result.arrayNews;
        
        // 将新数据插入到旧数据的最前面
        NSRange range = NSMakeRange(0, newss.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.arrayNews insertObjects:newss atIndexes:indexSet];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
        
        // 提示用户最新的微博数量
//        [self showNewStatusesCount:newFrames.count];
    } failure:^(NSError *error) {
        WJLog(@"请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
    }];
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatuses
{
    // 1.封装请求参数
    WJNewsParam *param = [WJNewsParam param];
    WJNews *lastNews = [self.arrayNews lastObject];
    if (lastNews) {
        param.max_id = @([lastNews.strID longLongValue] - 1);
    }
    
    // 2.加载微博数据
    [WJNewsTool newsWithParam:param success:^(WJNewsReturn *result) {
        // 获得最新的微博frame数组
        NSArray *newss = result.arrayNews;
        
        // 将新数据插入到旧数据的最后面
        [self.arrayNews addObjectsFromArray:newss];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        WJLog(@"请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJNewsCommonCell *cell = [WJNewsCommonCell cellWithTableView:tableView];
    
    cell.news = self.arrayNews[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJNews *news = self.arrayNews[indexPath.row];
    WJWebViewController *webVC = [[WJWebViewController alloc] init];
    webVC.strUrl = news.destUrl;
    webVC.title = news.title;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.arrayNews.count <= 0 || self.footer.isRefreshing) return;
    
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    // 2.如果能看见整个footer
    if (delta <= (sawFooterH - 0)) {
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的微博数据
            [self loadMoreStatuses];
        });
    }
}

@end
