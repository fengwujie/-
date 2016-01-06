//
//  WJServicesViewController.m
//  漳州公积金
//
//  Created by fengwujie on 16/1/4.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJServicesViewController.h"
#import "WJWebViewController.h"
#import "WJCalculatorViewController.h"

@interface WJServicesViewController ()

/** 贷款指南 */
@property (nonatomic, strong) UIButton *dkzn;
/** 提取指南 */
@property (nonatomic, strong) UIButton *tqzn;
/** 开户指南 */
@property (nonatomic, strong) UIButton *kfzn;
/** 公积金利率 */
@property (nonatomic, strong) UIButton *gjjll;
/** 贷款计算器 */
@property (nonatomic, strong) UIButton *dkjsq;

@end

@implementation WJServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WJRandomColor;
    [self setup];
}

/**
 初始化界面
 */
- (void) setup
{
    // 2.创建一个大窗口GridView
    UIView *gridView = [[UIView alloc] init];
    [self.view addSubview:gridView];
    gridView.backgroundColor = [UIColor clearColor];
    gridView.x = 0;
    gridView.y = 64;
    gridView.width = self.view.width;
    gridView.height = self.view.height;
    
    // 往GridView容器里面添加按钮
    float margin = 10;   //网格间距
    float multiple = 1.2;  //高度与宽度的位数
    // 2.1添加“贷款指南”
    UIButton *dkzn = [[UIButton alloc]init];
    [gridView addSubview:dkzn];
    self.dkzn = dkzn;
    dkzn.x = margin;
    dkzn.y = margin;
    dkzn.width = (gridView.width - margin * 3) * 0.5;
    dkzn.height = dkzn.width * multiple;
    [dkzn setTitle:@"贷款指南" forState:UIControlStateNormal];
    [dkzn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dkzn.backgroundColor = WJColor(80, 80, 150);
    [dkzn addTarget:self action:@selector(runWeb:) forControlEvents:UIControlEventTouchUpInside];
    
    // 2.2添加“提取指南”
    UIButton *tqzn = [[UIButton alloc]init];
    [gridView addSubview:tqzn];
    self.tqzn = tqzn;
    tqzn.x = margin + CGRectGetMaxX(dkzn.frame);
    tqzn.y = dkzn.y;
    tqzn.width = dkzn.width;
    tqzn.height = tqzn.width * multiple;
    [tqzn setTitle:@"提取指南" forState:UIControlStateNormal];
    [tqzn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tqzn.backgroundColor = WJColor(80, 180, 80);
    [tqzn addTarget:self action:@selector(runWeb:) forControlEvents:UIControlEventTouchUpInside];
    
    // 2.3添加“开户指南”
    UIButton *kfzn = [[UIButton alloc]init];
    [gridView addSubview:kfzn];
    self.kfzn = kfzn;
    kfzn.x = margin;
    kfzn.y = margin + CGRectGetMaxY(dkzn.frame);
    kfzn.width = dkzn.width;
    kfzn.height = kfzn.width * multiple;
    [kfzn setTitle:@"开户指南" forState:UIControlStateNormal];
    [kfzn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    kfzn.backgroundColor = WJColor(0, 0, 200);
    [kfzn addTarget:self action:@selector(runWeb:) forControlEvents:UIControlEventTouchUpInside];
    
    // 2.4添加“公积金利率”
    UIButton *gjjll = [[UIButton alloc]init];
    [gridView addSubview:gjjll];
    self.gjjll = gjjll;
    gjjll.x = margin + CGRectGetMaxX(kfzn.frame);
    gjjll.y = kfzn.y;
    gjjll.width = kfzn.width;
    gjjll.height = (kfzn.height - margin) * 0.5;
    [gjjll setTitle:@"公积金利率" forState:UIControlStateNormal];
    [gjjll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gjjll.backgroundColor = WJColor(80, 80, 150);
    [gjjll addTarget:self action:@selector(runWeb:) forControlEvents:UIControlEventTouchUpInside];
    
    // 2.5添加“贷款计算器”
    UIButton *dkjsq = [[UIButton alloc]init];
    [gridView addSubview:dkjsq];
    self.dkjsq = dkjsq;
    dkjsq.x = gjjll.x;
    dkjsq.y = margin + CGRectGetMaxY(gjjll.frame);
    dkjsq.width = gjjll.width;
    dkjsq.height = gjjll.height;
    [dkjsq setTitle:@"贷款计算器" forState:UIControlStateNormal];
    [dkjsq setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dkjsq.backgroundColor = WJColor(80, 180, 80);
    [dkjsq addTarget:self action:@selector(runWindow:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 跳转到网页
 */
- (void)runWeb : (UIButton *)btn
{
    WJWebViewController *webVC = [[WJWebViewController alloc] init];
    if ([btn isEqual:self.dkzn]) {  //贷款指南
        webVC.strUrl = WJUrlDKZN;
    }
    else if ([btn isEqual:self.tqzn]) {   //提取指南
        webVC.strUrl = WJUrlTQZN;
    }
    else if ([btn isEqual:self.kfzn]) {   //开户指南
        webVC.strUrl = WJUrlKFZN;
    }
    else if ([btn isEqual:self.gjjll]) {   //公积金利率
        webVC.strUrl = WJUrlGJJLL;
    }
    webVC.title = btn.titleLabel.text;
    [self.navigationController pushViewController:webVC animated:YES];
}

/**
 *  跳转窗体
 */
- (void)runWindow:(UIButton *)btn
{
    if ([btn isEqual:self.dkjsq]) {   //贷款计算器
        WJCalculatorViewController *calculatorVC = [[WJCalculatorViewController alloc] init];
        calculatorVC.title = btn.titleLabel.text;
        [self.navigationController pushViewController:calculatorVC animated:YES];
    }
}
@end
