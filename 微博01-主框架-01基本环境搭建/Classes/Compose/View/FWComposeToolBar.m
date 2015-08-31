//
//  FWComposeToolBar.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/29.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWComposeToolBar.h"

@interface FWComposeToolBar ()


@end

@implementation FWComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]]];
        
        [self addBtnWithImage:[UIImage imageWithName:@"compose_camerabutton_background"] highImage:[UIImage imageWithName:@"compose_camerabutton_background_highlighted"] tag:FWComposeToolBarButtonTypeCamera];
        
        [self addBtnWithImage:[UIImage imageWithName:@"compose_emoticonbutton_background"] highImage:[UIImage imageWithName:@"compose_emoticonbutton_background_highlighted"] tag:FWComposeToolBarButtonTypeEmotion];
        
        [self addBtnWithImage:[UIImage imageWithName:@"compose_mentionbutton_background"] highImage:[UIImage imageWithName:@"compose_mentionbutton_background_highlighted"] tag:FWComposeToolBarButtonTypeMention];
        
        [self addBtnWithImage:[UIImage imageWithName:@"compose_toolbar_picture"] highImage:[UIImage imageWithName:@"compose_toolbar_picture_highlighted"] tag:FWComposeToolBarButtonTypePicture];
        
        [self addBtnWithImage:[UIImage imageWithName:@"compose_trendbutton_background"] highImage:[UIImage imageWithName:@"compose_trendbutton_background_highlighted"] tag:FWComposeToolBarButtonTypeTrend];
         
    }
    return self;
}

- (void)addBtnWithImage:(UIImage *)image highImage:(UIImage *)highImage tag:(FWComposeToolBarButtonType)tag
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    
    btn.tag = tag;
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}

/**
 *  工具条按钮点击事件
 */
- (void)btnClick:(UIButton *)btn
{
//    点击按钮会有控制器跳转，应该在控制器里完成，设置代理，按钮点击后通知控制器执行代理方法
    /*
        关于确定是哪一个按钮点击事件，可以判断
     思考：
     1.图片不一样判断图片
     //    UIImage *image = [btn imageForState:UIControlStateNormal];
     //    if (image == [UIImage imageWithName:@"compose_toolbar_picture"]) {
     //    }
     此方法可以实现功能但是暴露了图片在控制器里面面，不符合封装的思想规范
     2.按照按钮创建顺序设置tag，用switch
     同样暴露了按钮顺序，而且tag无法区分有哪些按钮，创建按钮顺序改变了就要修改自定义文件代码
     3.利用枚举
     通过枚举名字说明是什么按钮，通过枚举名字判断哪个按钮设置对应事件，不会因为创建顺序改变而改变
     还有代理方法直接传tag传btn的btn本身没有用到
     */

    
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickBtnTag:)]) {
        [self.delegate composeToolBar:self didClickBtnTag:(FWComposeToolBarButtonType)btn.tag];
    }
}


/**
 *  设置子控件frame
 */
- (void)layoutSubviews
{
    NSInteger count = self.subviews.count;
    CGFloat btnY = 0;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnX = btnW * i;
        
        btn.x = btnX;
        btn.y = btnY;
        btn.width = btnW;
        btn.height = btnH;
    }
}





@end
