//
//  FWComposePhotosView.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/29.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWComposePhotosView.h"

@implementation FWComposePhotosView


- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    NSInteger count = self.subviews.count;
    
//    间隙
    NSInteger margin = 10;
//    一行图片的数量
    NSInteger maxRow = 4;
    
    CGFloat imageViewW = (self.width - (maxRow + 1) * margin) / maxRow;
    CGFloat imageViewH = imageViewW;


    
    
    for (NSInteger i = 0; i < count; i++) {
//        行号
        NSInteger row = i / maxRow;
//        列号
        NSInteger col = i % maxRow;
        
//        取出imageView设置frame
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.x = col * (imageViewW + margin) + margin;
        imageView.y = row * (imageViewH + margin);
    }
}

- (NSArray *)images
{
    NSMutableArray *imageArr = [NSMutableArray array];
    
    for (UIImageView *imageview in self.subviews) {
        [imageArr addObject:imageview.image];
    }
    return imageArr;
}

@end
