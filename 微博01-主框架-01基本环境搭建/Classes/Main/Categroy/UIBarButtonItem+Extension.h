//
//  UIBarButtonItem+Extension.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/19.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)barBtnWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
