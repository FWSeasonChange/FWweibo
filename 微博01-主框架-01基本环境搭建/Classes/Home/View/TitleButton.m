//
//  TitleButton.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/20.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        文字居右
        self.titleLabel.textAlignment = NSTextAlignmentRight;
//        图片居中，显示原图，不会拉伸图片
        self.imageView.contentMode = UIViewContentModeCenter;
        //    文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //    文字大小
        self.titleLabel.font = FWNavigationBarFont;
        //    按下按钮不调整图片
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

/**
 *  返回按钮图片在按钮的显示范围
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
//    先设置图片因为图片的大小固定
    CGFloat imageW = self.height;
    CGFloat imageX = self.width - imageW;
    CGFloat imageY = 0;
    CGFloat imageH = self.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}

/**
 *  发挥按钮文字再按钮的显示范围
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = self.width - self.height;
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
//    获取字体size
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font];
    
//    按钮的宽度 = 文字宽度 + 图片宽度 +
    self.width = titleSize.width + self.height + 10;
}

@end
