//
//  WJHomeViewController.m
//  漳州公积金
//
//  Created by fengwujie on 16/1/4.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJHomeViewController.h"
#import "WJWebViewController.h"

@interface WJHomeViewController ()
/** 我的公积金 */
@property (nonatomic, strong) UIButton *gjj;
/** 贷款指南 */
@property (nonatomic, strong) UIButton *dkzn;
/** 提取指南 */
@property (nonatomic, strong) UIButton *tqzn;

@end

@implementation WJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *titleView = [[UIButton alloc] init];
    [titleView setTitle:@"漳州市住房公积金管理中心" forState:UIControlStateNormal];
    [titleView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.titleView = titleView;
    
    [self setup];
}
/**
 初始化界面
 */
- (void) setup
{
    // 1.创建label
    UILabel *topLable = [[UILabel alloc] init];
    [self.view addSubview:topLable];
    topLable.x = 0;
    topLable.y = 64;
    topLable.width = self.view.width;
    topLable.height = 44;
    topLable.numberOfLines = 0;
    topLable.text =@"  尊敬的用户，下午好！\n  欢迎使用漳州市掌上住房公积金";
    
    // 2.创建一个大窗口GridView
    UIView *gridView = [[UIView alloc] init];
    [self.view addSubview:gridView];
    gridView.backgroundColor = [UIColor clearColor];
    gridView.x = 0;
    gridView.y = CGRectGetMaxY(topLable.frame);
    gridView.width = self.view.width;
    gridView.height = self.view.height - gridView.y;
    
    // 往GridView容器里面添加按钮
    float margin = 10;   //网格间距
    float multiple = 1.2;  //高度与宽度的位数
    // 2.1添加“我的公积金”
    UIButton *gjj = [[UIButton alloc]init];
    [gridView addSubview:gjj];
    self.gjj = gjj;
    gjj.x = margin;
    gjj.y = margin;
    gjj.width = (gridView.width - margin * 3) * 0.5;
    gjj.height = gjj.width * multiple;
    [gjj setTitle:@"我的公积金" forState:UIControlStateNormal];
    [gjj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gjj.backgroundColor = WJColor(200, 0, 0);
    [gjj addTarget:self action:@selector(runWeb:) forControlEvents:UIControlEventTouchUpInside];
    
    // 2.2添加“政策法规”
    UIButton *zcfg = [[UIButton alloc]init];
    [gridView addSubview:zcfg];
    zcfg.x = margin + CGRectGetMaxX(gjj.frame);
    zcfg.y = gjj.y;
    zcfg.width = gjj.width;
    zcfg.height = zcfg.width * multiple;
    [zcfg setTitle:@"政策法规" forState:UIControlStateNormal];
    [zcfg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zcfg.backgroundColor = WJColor(0, 200, 0);
    
    // 2.3添加“办事指南”
    UIButton *bszn = [[UIButton alloc]init];
    [gridView addSubview:bszn];
    bszn.x = margin;
    bszn.y = margin + CGRectGetMaxY(gjj.frame);
    bszn.width = gjj.width;
    bszn.height = bszn.width * multiple;
    [bszn setTitle:@"办事指南" forState:UIControlStateNormal];
    [bszn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bszn.backgroundColor = WJColor(0, 0, 200);
    
    // 2.4添加“贷款指南”
    UIButton *dkzn = [[UIButton alloc]init];
    [gridView addSubview:dkzn];
    self.dkzn = dkzn;
    dkzn.x = margin + CGRectGetMaxX(bszn.frame);
    dkzn.y = bszn.y;
    dkzn.width = bszn.width;
    dkzn.height = (bszn.height - margin) * 0.5;
    [dkzn setTitle:@"贷款指南" forState:UIControlStateNormal];
    [dkzn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dkzn.backgroundColor = WJColor(80, 80, 150);
    [dkzn addTarget:self action:@selector(runWeb:) forControlEvents:UIControlEventTouchUpInside];
    
    // 2.5添加“提取指南”
    UIButton *tqzn = [[UIButton alloc]init];
    [gridView addSubview:tqzn];
    self.tqzn = tqzn;
    tqzn.x = dkzn.x;
    tqzn.y = margin + CGRectGetMaxY(dkzn.frame);
    tqzn.width = dkzn.width;
    tqzn.height = dkzn.height;
    [tqzn setTitle:@"贷款指南" forState:UIControlStateNormal];
    [tqzn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tqzn.backgroundColor = WJColor(80, 180, 80);
    [tqzn addTarget:self action:@selector(runWeb:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 跳转到网页
 */
- (void)runWeb : (UIButton *)btn
{
    WJWebViewController *webVC = [[WJWebViewController alloc] init];
    if ([btn isEqual:self.gjj]) {   //我的公积金
        webVC.strUrl = @"https://www.baidu.com";
    }
    else if ([btn isEqual:self.dkzn]) {  //贷款指南
        webVC.strUrl = @"http://www.jd.com";
    }
    else if ([btn isEqual:self.tqzn]) {   //提取指南
        webVC.strUrl = @"http://www.mi.com";
    }
    webVC.title = btn.titleLabel.text;
    [self.navigationController pushViewController:webVC animated:YES];
}


@end
