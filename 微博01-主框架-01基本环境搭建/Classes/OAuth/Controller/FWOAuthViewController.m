//
//  FWOAuthViewController.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/25.
//  Copyright (c) 2015年 付玮. All rights reserved.
//



#import "FWOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "TabBarViewController.h"
#import "FWFeatureViewController.h"
#import "FWControllerTool.h"
#import "FWAccountModel.h"
#import "FWAccountTool.h"
#import "FWHttpTool.h"

@interface FWOAuthViewController()<UIWebViewDelegate>


@end

@implementation FWOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    需要获取未授权的Request Token，就是新浪提供的用户登录界面，需要UIWebView显示
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    
    /*
     https://api.weibo.com/oauth2/authorize?第三方授权登陆
     client_id=你的自己制作的应用的新浪给的AppKey
     redirect_uri=授权成功登陆跳转的页面
     */
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", FWAppKey, FWRedirect_uri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    需要加载URLRequest
    [webView loadRequest:request];
    
    //    设置代理监听请求发送拦截获取授权后的code
    webView.delegate = self;
}

#pragma mark - UIWebViewDelegate

/**
 *  webView开始加载加载
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在努力加载..."];
}
/**
 *  webView结束加载
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
/**
 *  每当有有加载request请求都会通过这个方法来决定是否加载
 *  @param request        需要加载的请求
 *
 *  @return YES允许加载 NO不允许加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    获取请求的url
    NSString *url = request.URL.absoluteString;
    
    //    rangeOfString:查找urlStr字符串再url字符串的位置
    /*
     typedef struct _NSRange {
     NSUInteger location; 起始位置
     NSUInteger length; 从起始位置开始计算字符串的长度
     } NSRange;
     
     */
    NSString *urlStr = [NSString stringWithFormat:@"%@/?code=", FWRedirect_uri];
    NSRange range = [url rangeOfString:urlStr];
    /*
     如果url = http://www.hao123.com/?code=677066ceba96170b019af5d319c60bbe
     得到的
     range.location = 0;
     range.length = 字符串的长度;
     
     如果url = https://api.weibo.com/oauth2/authorize
     range.location = NSNotFound;
     range.length = 0;
     */
    if (range.location != NSNotFound) {
        NSInteger index = (range.location + range.length);
        //        截取字符串获取code ，code每次都不同
        //    substringFromIndex:从这个位置开始截取之后的字符串
        //    [url substringToIndex:<#(NSUInteger)#>] 截取index范围之内的字符串
        //    [url subst   ringWithRange:<#(NSRange)#>] 截取range范围之内的字符串
        FWLog(@"%@", url);
        NSString *code = [url substringFromIndex:index];
        FWLog(@"code = %@", code);
        
        //        根据code获取Access Token
        [self accessTokenWithCode:code];
        
        //        获取到code之后禁止跳转页面，
        return NO;
    }
    
    return YES;
}

/**
 *  根据code获取AccessToken（发送一个POST请求）
 */
- (void)accessTokenWithCode:(NSString *)code
{
    //    //    1.获得请求管理者
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //
    //    /*这个方法用于发送文件
    //     mgr POST:<#(NSString *)#> parameters:<#(id)#> constructingBodyWithBlock:<#^(id<AFMultipartFormData> formData)block#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>
    //     */
    //
    //    //    2.封装请求参数
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params[@"client_id"] = FWAppKey;
    //    params[@"client_secret"] = FWAppSecret;
    //    params[@"grant_type"] = @"authorization_code";
    //    params[@"code"] = code;
    //    params[@"redirect_uri"] = FWRedirect_uri;
    //
    //    /*
    //     POST:请求的链接，官方API文档提供
    //     parameters:POST请求需要的参数，详情看官方API文档
    //     success:成功执行的block
    //     responseObject:服务器返回的数据，是一个字典
    //     failure:失败执行的block
    //     error:失败的原因
    //     */
    //    //    发送POST请求,获取到Access Token就不会再到授权页面了
    //    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *accountDict) {
    //        [MBProgressHUD hideHUD];
    //
    //        /*
    //         建议不用plist，这是一个字典，每次通过account[@"access_token"]key取值，麻烦，key写错了也不会报错，把数据存储成模型，面向买模型开发，不面向字典开发
    //         每次请求都得带上Access Token
    //         模型开发有提示写错会报错，减少粗心的麻烦
    //         统一账号管理：搞一个工具类，存储，读取账号
    //         */
    //
    //        //字典转模型
    //        FWAccountModel *account = [FWAccountModel accountWithDict:accountDict];
    //
    //        //保存模型，就是保存账号
    //        [FWAccountTool saveAccount:account];
    //
    //        //        判断选择控制器
    //        [FWControllerTool chooseRootViewController];
    //
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        [MBProgressHUD hideHUD];
    //
    //        FWLog(@"请求失败---%@", error);
    //    }];
    
    //    2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = FWAppKey;
    params[@"client_secret"] = FWAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = FWRedirect_uri;
    
    [FWHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id responseObj) {
        
        [MBProgressHUD hideHUD];
        
        //字典转模型
        FWAccountModel *account = [FWAccountModel accountWithDict:responseObj];
        
        //保存模型，就是保存账号
        [FWAccountTool saveAccount:account];
        
        //        判断选择控制器
        [FWControllerTool chooseRootViewController];
        
    } failure:^(NSError *error) {
        FWLog(@"请求失败---%@", error);
        
    }];
}

@end
