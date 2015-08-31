//
//  UIImage+Extensions.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/18.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "UIImage+Extensions.h"

@implementation UIImage (Extensions)
/**
 *   图片iOS6、7适配
 */
+ (UIImage *)imageWithName:(NSString *)imageName
{
    UIImage *image = nil;
    if (iOSVersion >= 7.0) {
        //        NSString *NewName = [NSString stringWithFormat:@"%@_os7", imageName];
        //        是iOS7就拼接图片名字
        NSString *newName = [imageName stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    if (image == nil) {
        image = [UIImage imageNamed:imageName];
    }
    return image;
}

+ (UIImage *)resizeWithImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageWithName:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
