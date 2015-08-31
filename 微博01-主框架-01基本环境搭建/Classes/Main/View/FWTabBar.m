//
//  FWTabBar.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/21.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWTabBar.h"


@interface FWTabBar ()

/**
 *  加号按钮
 */
@property (nonatomic, strong) UIButton *plusBtn;


@end
@implementation FWTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        if (iOSVersion < 7.0) {
            
            //    设置背景图片
            self.backgroundImage = [UIImage imageWithName:@"tabbar_background"];
        }
        //    设置选中背景图片
        self.selectionIndicatorImage = [UIImage imageWithName:@"navigationbar_button_background"];
        
        [self setupPlusButton];
    }
    return self;
}
/**
 *  设置加号按钮
 */
- (void)setupPlusButton
{
    UIButton *plusBtn = [[UIButton alloc]init];
    
//    设置背景图片
    [plusBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
//    设置图片
    [plusBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
//    添加点击事件
    [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    加到TabBar
    [self addSubview:plusBtn];
    
//    保存为全局
    self.plusBtn = plusBtn;
}

/**
 *  加号按钮点击
 */
- (void)plusBtnClick
{
    if ([self.tabarDelegate respondsToSelector:@selector(tabBarDidClickPlusBtn:)]) {
        [self.tabarDelegate tabBarDidClickPlusBtn:self];
    }
}

/**
 *  子控件布局方法设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    设置加号按钮的frame
    [self setPlusBtnFrame];
    
//    设置四个按钮的frame
    [self setAllTabBarBtnFrame];
}

/**
 *  设置加号按钮的frame
 */
- (void)setPlusBtnFrame
{
    self.plusBtn.size = self.plusBtn.currentBackgroundImage.size;
    self.plusBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

/**
 *  设置四个按钮的frame
 */
- (void)setAllTabBarBtnFrame
{
    int index = 0;
    
//    设置文字颜色
    
    
//    遍历子控件
    for (UIView *TabBarButton in self.subviews) {
        
//        找出UITabBarButton
        if (![TabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
//        设置单个按钮的frame
        [self setTabBarBtnFrame:TabBarButton atIndex:index];
        
//        索引增加
        index++;
    }
}

/**
 *  设置单个按钮的frame
 */
- (void)setTabBarBtnFrame:(UIView *)tabBarBtn atIndex:(int)index
{
    CGFloat tabbarBtnY = 0;
    CGFloat tabbarBtnH = self.height;
    CGFloat tabbarBtnW = self.width / (self.items.count + 1);
    CGFloat tabbarBtnX = tabbarBtnW * index;
    if (index > 1) {
        tabbarBtnX = tabbarBtnW * (index + 1);

    }
    tabBarBtn.frame = CGRectMake(tabbarBtnX, tabbarBtnY, tabbarBtnW, tabbarBtnH);
}


@end
