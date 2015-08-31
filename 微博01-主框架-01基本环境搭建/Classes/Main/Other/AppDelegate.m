//
//  AppDelegate.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/18.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "FWFeatureViewController.h"
#import "FWOAuthViewController.h"
#import "FWControllerTool.h"
#import "FWAccountTool.h"
#import "FWAccountModel.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.statusBarHidden = NO;
    
    //    1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //    3.设置窗口为主窗口和显示,要在判断之前设置因为，判断里面会获取主窗口，不设置就会是nil
    [self.window makeKeyAndVisible];
    
    FWAccountModel *account = [FWAccountTool getAccount];
        //    2.设置窗口的根控制器
    if (account) {
        
        //  这段代码两个地方要用用到两个不同文件，写一个工具类保存
        //        判断选择控制器
        [FWControllerTool chooseRootViewController];
        
    }
    
    else{//没有账号
        
        self.window.rootViewController = [[FWOAuthViewController alloc]init];
    }
    
//    监听网络状况
    AFNetworkReachabilityManager *mgr = [[AFNetworkReachabilityManager alloc]init];
//    当网络状态改变了就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [MBProgressHUD showError:@"未知网络"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [MBProgressHUD showError:@"网络连接异常"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                FWLog(@"手机网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                FWLog(@"网络为WIFI");
                break;

        }
        
    }];
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
//    清楚内存缓存
    [[SDImageCache sharedImageCache]clearMemory];
    
//    停止正在进行的下载图片操作
    [[SDWebImageManager sharedManager] cancelAll];
}


@end
