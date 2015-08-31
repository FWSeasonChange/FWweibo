//
//  UIImage+Extensions.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/18.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)
/**
 *  返回一张适配iOS6、7的图片
 */
+ (UIImage *)imageWithName:(NSString *)imageName;
/**
 *  返回一张可以平铺的图片
 */
+ (UIImage *)resizeWithImage:(NSString *)imageName;

@end
