//
//  WJWebViewController.m
//  漳州公积金
//
//  Created by fengwujie on 16/1/4.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJWebViewController.h"

@interface WJWebViewController ()

@end

@implementation WJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    webView.frame = self.view.bounds;
    // 设置属性：
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
//    webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    
    NSURL* url = [NSURL URLWithString: self.strUrl];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
}

@end
