//
//  UIBarButtonItem+Extension.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/19.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *  返回自定义UIBarButtonItem
 */
+ (UIBarButtonItem *)barBtnWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:highImageName] forState:UIControlStateHighlighted];
    //    设置按钮大小等于图片大小
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //    传入一个自定义view
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
