//
//  FWPopMenu.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/20.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWPopMenu.h"

@interface FWPopMenu ()
/**
 *  下拉菜单按钮
 */
@property (nonatomic, strong) UIView *contentButton;
/**
 遮盖按钮
 */
@property (nonatomic, strong) UIButton *coverBtn;

/**
 图片
 */
@property (nonatomic, strong) UIImageView *arrowImage;



@end

@implementation FWPopMenu


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        添加两个子控件
//        1.遮盖按钮
        UIButton *coverBtn = [[UIButton alloc]init];
//    点击事件
        [coverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverBtn];
        self.coverBtn = coverBtn;
        
//        2.显示图片
        UIImageView *arrowImage = [[UIImageView alloc]init];
        arrowImage.userInteractionEnabled = YES;
        arrowImage.image = [UIImage resizeWithImage:@"popover_background"];
        self.popMenuArrowPostion = FWPopMenuArrowPostionCenter;
        [self addSubview:arrowImage];
        self.arrowImage = arrowImage;
    }
    return self;
}
/**
 *  遮盖按钮点击事件
 */
- (void)coverClick
{
    [self dismiss];
}
/**
 *  移除把遮盖按钮从父视图上移除，遮盖按钮上的所有东西都会没有，通知代理控制器变换图片
 */
- (void)dismiss
{
//    通知代理实现方法
    if ([self.delegate respondsToSelector:@selector(popMenuDidDismissed:)]) {
        [self.delegate popMenuDidDismissed:self];
    }
//    从父视图移除
    [self removeFromSuperview];
    
}
/**
 *  设置遮盖按钮的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.coverBtn.frame = self.bounds;
}

- (void)showInRect:(CGRect)rect
{
//    将菜单视图添加到window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
//    设置UIImageView的frame
    self.arrowImage.frame = rect;
//    将按钮加到图片上
    [self.arrowImage addSubview:self.contentButton];
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 15;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 10;
    
    self.contentButton.y = topMargin;
    self.contentButton.x = leftMargin;
    self.contentButton.width = self.arrowImage.width - leftMargin - rightMargin;
    self.contentButton.height = self.arrowImage.height - topMargin - bottomMargin;
}
/**
 *  设置下拉窗口图片
 */
- (void)setPopMenuArrowPostion:(FWPopMenuArrowPostion)popMenuArrowPostion
{
    _popMenuArrowPostion = popMenuArrowPostion;
    switch (_popMenuArrowPostion) {
        case FWPopMenuArrowPostionCenter:
//            截取一小块图片self.arrowImage.image平铺显示
            self.arrowImage.image = [UIImage resizeWithImage:@"popover_background"];
            break;
        case FWPopMenuArrowPostionRight:
            self.arrowImage.image = [UIImage resizeWithImage:@"popover_background_right"];
            break;
        case FWPopMenuArrowPostionLeft:
            self.arrowImage.image = [UIImage resizeWithImage:@"popover_background_left"];
            break;
    }
}
/**
 *设置遮罩透明度和颜色
 */
- (void)setDismissBackground:(BOOL)dismissBackground
{
    _dismissBackground = dismissBackground;
    if (dismissBackground) {
//        alpha越大越黑
        self.coverBtn.backgroundColor = [UIColor blackColor];
        self.coverBtn.alpha = 0.2;
    }else
    {
        self.coverBtn.backgroundColor = [UIColor clearColor];
        self.coverBtn.alpha = 1.0;
    }
}
- (instancetype)initWithContentButton:(UIView *)button
{
    self = [super init];
    if (self) {

        self.contentButton = (UIView *)button;
    }
    return self;
}

//初始化类方法
+ (instancetype)popMenuWithContentButton:(UIView *)button
{
    return [[self alloc]initWithContentButton:button];
}


@end
