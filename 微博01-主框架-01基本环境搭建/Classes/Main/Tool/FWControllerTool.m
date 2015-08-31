//
//  FWControllerTool.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/26.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWControllerTool.h"
#import "TabBarViewController.h"
#import "FWFeatureViewController.h"

@implementation FWControllerTool

+ (void)chooseRootViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //    从沙盒中取出上一次版本号
    NSString *versionKey = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:versionKey];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    //    创建新特性控制器
    //    打印info.plist,CFBundleVersion版本号的key
    if ([currentVersion isEqualToString:lastVersion]) {
        //        版本号相同则不显示新特性
        window.rootViewController = [[TabBarViewController alloc]init];
        
    }
    else
    {   //第一次运行，将控制器设置成显示新特性的控制器
        window.rootViewController = [[FWFeatureViewController alloc]init];
        //        存储新的版本号
        [defaults setObject:currentVersion forKey:versionKey];
        //        立即同步存储
        [defaults synchronize];
        
    }
}
@end
