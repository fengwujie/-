//
//  WJHomeViewController.m
//  漳州公积金
//
//  Created by fengwujie on 16/1/4.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJHomeViewController.h"
#import "WJWebViewController.h"
#import "WJHomeButton.h"
#import "WJHomeButtonSmall.h"
#import "WJNewsCommonViewController.h"

@interface WJHomeViewController ()
/** 我的公积金 */
@property (nonatomic, strong) WJHomeButton *gjj;
/** 贷款指南 */
@property (nonatomic, strong) WJHomeButtonSmall *dkzn;
/** 提取指南 */
@property (nonatomic, strong) WJHomeButtonSmall *tqzn;
/** 政策法规 */
@property (nonatomic, strong) WJHomeButton *zcfg;
/** 办事指南 */
@property (nonatomic, strong) WJHomeButton *bszn;

@end

@implementation WJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WJGlobalBg;
    UIButton *titleView = [[UIButton alloc] init];
    titleView.width=400;
    titleView.height=44;
    [titleView setTitle:@"漳州市住房公积金管理中心" forState:UIControlStateNormal];
    [titleView.titleLabel setFont:WJNavigationTitleFont];
    [titleView setImage:[UIImage imageNamed:@"gjj_logo32"] forState:UIControlStateNormal];
    [titleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleView setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    self.navigationItem.titleView = titleView;
    [self setup];
}
/**
 初始化界面
 */
- (void) setup
{
    UIImageView* topView = [[UIImageView alloc] init];
    [self.view addSubview:topView];
    topView.x = 0;
    topView.y = 0;
    topView.width = self.view.width;
    topView.height = 50;
    topView.image = [UIImage imageNamed:@"image_bg"];
    
    // 1.创建label
    UILabel *topLable = [[UILabel alloc] init];
    [self.view addSubview:topLable];
    topLable.backgroundColor = [UIColor clearColor];
    topLable.frame = topView.frame;
//    topLable.x = 0;
//    topLable.y = 64;
//    topLable.width = self.view.width;
//    topLable.height = 44;
    topLable.numberOfLines = 0;
    topLable.textColor = WJColor(122, 122, 122);
    topLable.text =@"   尊敬的用户，下午好！\n   欢迎使用漳州市掌上住房公积金";
    
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
    WJHomeButton *gjj = [WJHomeButton homeButton];
    [gridView addSubview:gjj];
    self.gjj = gjj;
    gjj.x = margin;
    gjj.y = margin;
    gjj.width = (gridView.width - margin * 3) * 0.5;
    gjj.height = gjj.width * multiple;
    gjj.backgroundColor = WJColor(253, 98, 124);
    [gjj setImageName:@"ic_my_gjj" text:@"我的公积金"];
    // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
//    UITapGestureRecognizer *recognizerGJJ = [[UITapGestureRecognizer alloc] init];
//    [recognizerGJJ addTarget:self action:@selector(buttonClick:)];
//    [gjj addGestureRecognizer:recognizerGJJ];
    [self addTapGestureRecognizer:gjj];
    
    // 2.2添加“政策法规”
    WJHomeButton *zcfg = [WJHomeButton homeButton];
    [gridView addSubview:zcfg];
    self.zcfg = zcfg;
    zcfg.x = margin + CGRectGetMaxX(gjj.frame);
    zcfg.y = gjj.y;
    zcfg.width = gjj.width;
    zcfg.height = zcfg.width * multiple;
    zcfg.backgroundColor = WJColor(98, 194, 3);
    [zcfg setImageName:@"ic_policy" text:@"政策法规"];
    // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
    [self addTapGestureRecognizer:zcfg];
//    UITapGestureRecognizer *recognizerZCFG = [[UITapGestureRecognizer alloc] init];
//    [recognizerZCFG addTarget:self action:@selector(buttonClick:)];
//    [zcfg addGestureRecognizer:recognizerZCFG];
    
    // 2.3添加“办事指南”
    WJHomeButton *bszn = [WJHomeButton homeButton];
    [gridView addSubview:bszn];
    self.bszn = bszn;
    bszn.x = margin;
    bszn.y = margin + CGRectGetMaxY(gjj.frame);
    bszn.width = gjj.width;
    bszn.height = bszn.width * 1.5;
    bszn.backgroundColor = WJColor(35, 183, 233);
    [bszn setImageName:@"ic_loan" text:@"办事指南"];
    // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
    [self addTapGestureRecognizer:bszn];
//    UITapGestureRecognizer *recognizerBSZN = [[UITapGestureRecognizer alloc] init];
//    [recognizerBSZN addTarget:self action:@selector(buttonClick:)];
//    [bszn addGestureRecognizer:recognizerBSZN];
    
    // 2.4添加“贷款指南”
    WJHomeButtonSmall *dkzn = [WJHomeButtonSmall homeButtonSmall];
    [gridView addSubview:dkzn];
    self.dkzn = dkzn;
    dkzn.x = margin + CGRectGetMaxX(bszn.frame);
    dkzn.y = bszn.y;
    dkzn.width = bszn.width;
    dkzn.height = (bszn.height - margin) * 0.5;
    dkzn.backgroundColor = WJColorDKZN;
    [dkzn setImageName:@"ic_guide" text:@"贷款指南"];
    // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
    [self addTapGestureRecognizer:dkzn];
//    UITapGestureRecognizer *recognizerDKZN= [[UITapGestureRecognizer alloc] init];
//    [recognizerDKZN addTarget:self action:@selector(buttonClick:)];
//    [dkzn addGestureRecognizer:recognizerDKZN];
    
    // 2.5添加“提取指南”
    WJHomeButtonSmall *tqzn = [WJHomeButtonSmall homeButtonSmall];
    [gridView addSubview:tqzn];
    self.tqzn = tqzn;
    tqzn.x = dkzn.x;
    tqzn.y = margin + CGRectGetMaxY(dkzn.frame);
    tqzn.width = dkzn.width;
    tqzn.height = dkzn.height;
    tqzn.backgroundColor = WJColorTQZN;
    [tqzn setImageName:@"ic_material" text:@"提取指南"];
    // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
    [self addTapGestureRecognizer:tqzn];
//    UITapGestureRecognizer *recognizerTQZN= [[UITapGestureRecognizer alloc] init];
//    [recognizerTQZN addTarget:self action:@selector(buttonClick:)];
//    [tqzn addGestureRecognizer:recognizerTQZN];
}
/**
 *  添加一个手势监听器
 */
-(void) addTapGestureRecognizer:(UIView *)view
{
    // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
    UITapGestureRecognizer *recognizer= [[UITapGestureRecognizer alloc] init];
    [recognizer addTarget:self action:@selector(buttonClick:)];
    [view addGestureRecognizer:recognizer];
}

-(void) buttonClick:(UITapGestureRecognizer *)recognizer
{
    UIView *view = recognizer.view;
    if ([view isEqual:self.gjj]) {   //我的公积金
        WJWebViewController *webVC = [[WJWebViewController alloc] init];
        webVC.strUrl = WJUrlGJJ;
        webVC.title = ((WJHomeButton *)view).text;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else if ([view isEqual:self.dkzn]) {  //贷款指南
        WJWebViewController *webVC = [[WJWebViewController alloc] init];
        webVC.strUrl = WJUrlDKZN;
        webVC.title = ((WJHomeButtonSmall *)view).text;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else if ([view isEqual:self.tqzn]) {   //提取指南
        WJWebViewController *webVC = [[WJWebViewController alloc] init];
        webVC.strUrl = WJUrlTQZN;
        webVC.title = ((WJHomeButtonSmall *)view).text;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    else if ([view isEqual:self.zcfg]) {   //政策法规
        WJNewsCommonViewController *newsVC = [[WJNewsCommonViewController alloc] init];
        newsVC.lmid = @5;
        newsVC.title = ((WJHomeButton *)view).text;
        [self.navigationController pushViewController:newsVC animated:YES];
    }
    else if ([view isEqual:self.bszn]) {  //办事指南
        WJNewsCommonViewController *newsVC = [[WJNewsCommonViewController alloc] init];
        newsVC.lmid = @7;
        newsVC.title = ((WJHomeButton *)view).text;
        [self.navigationController pushViewController:newsVC animated:YES];
    }
}

/**
 跳转到网页
 */
- (void)runWeb : (UIButton *)btn
{
    WJWebViewController *webVC = [[WJWebViewController alloc] init];
    if ([btn isEqual:self.gjj]) {   //我的公积金
        webVC.strUrl = WJUrlGJJ;
    }
    else if ([btn isEqual:self.dkzn]) {  //贷款指南
        webVC.strUrl = WJUrlDKZN;
    }
    else if ([btn isEqual:self.tqzn]) {   //提取指南
        webVC.strUrl = WJUrlTQZN;
    }
    webVC.title = btn.titleLabel.text;
    [self.navigationController pushViewController:webVC animated:YES];
}
/**
 *  跳转窗体
 */
- (void)runWindow:(UIButton *)btn
{
    WJWebViewController *webVC = [[WJWebViewController alloc] init];
    if ([btn isEqual:self.zcfg]) {   //政策法规
        webVC.strUrl = @"https://www.baidu.com";
    }
    else if ([btn isEqual:self.bszn]) {  //办事指南
        webVC.strUrl = @"http://www.jd.com";
    }
    webVC.title = btn.titleLabel.text;
    [self.navigationController pushViewController:webVC animated:YES];
}
@end
