//
//  总结.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/25.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

授权分析看授权分析.h
OAuth授权本次程序代码总结
1.当用户没有本地登录账号记录时就会启动一个新的控制器来让用户登录程序

2.和判断新版本特新一样判断用户沙盒中是否保存了账号数据也就是Access Token字典

3.没有则创建一个UIWebView用来显示新浪提供的登陆界面，由于是第三方应用需要用户授权

4.本地应用发送一个带有client_id和redirect_uri的链接获得Request Token就是获取服务商的登陆界面

5.进行登录第一次授权会显示授权界面授权完成后会自动跳转到回调界面redirect_uri此时可以通过拦截requestURL回调页面网址后面会加上/?code=....我们需要code=之后的东西来获取Access Token
5.1 如何获取code:通过此方法可以获取每一条requesturl请求
/**
 *  每当有有加载request请求都会通过这个方法来决定是否加载
 *  @param request        需要加载的请求
 *
 *  @return YES允许加载 NO不允许加载
 */
- (BOOL)webView: shouldStartLoadWithRequest: navigationType:

//    获取请求的url
NSString *url = request.URL.absoluteString;
通过rangeOfString:redirect_uri来获得一个range，然后来截取之后的字符串substringFromIndex:
此方法可以截取index之后的字符串获得code


6.通过AFNetWorking框架中的方法获得responseObject如果POST成功了就是需要的Access Token字典模型，保存到本地文档中
/*
 POST:请求的链接，官方API文档提供
 parameters:POST请求需要的参数，详情看官方API文档，数据用字典包装
 success:成功执行的block
 responseObject:服务器返回的数据，是一个字典
 failure:失败执行的block
 error:失败的原因
 */
//    发送POST请求,获取到Access Token就不会再到授权页面了
[mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
}];

7.如果本地文档中有Access Token就可以直接登录免去登录和授权界面，授权只需要一次，除非手动接触授权，继续哦按段用户是否为第一次使用新版本，是否显示新版本控制器还是直接显示用户数据界面



