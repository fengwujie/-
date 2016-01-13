//
//  WJWebViewController.m
//  漳州公积金
//
//  Created by fengwujie on 16/1/4.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJWebViewController.h"
#import "MBProgressHUD+MJ.h"

@interface WJWebViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation WJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]  initWithFrame :CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicatorView setCenter: self.view.center];
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray];
    [self.view addSubview : activityIndicatorView];
    self.activityIndicatorView = activityIndicatorView;
    
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    // 设置属性：
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
//    webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    
    NSURL* url = [NSURL URLWithString: self.strUrl];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@""];
//    [self.activityIndicatorView startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
//    [self.activityIndicatorView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
//    [self.activityIndicatorView stopAnimating];
//    WJLog(@"Fail:error:%@, WebView:%@",error, webView.request.URL);
//    [MBProgressHUD showError: [NSString stringWithFormat: @"加载数据出错：%@", error]];
}
@end
