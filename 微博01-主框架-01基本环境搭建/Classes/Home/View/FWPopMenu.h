//
//  FWPopMenu.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/20.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWPopMenu;

/**
 创建一个枚举类型，类型名字为FWPopMenuArrowPostion，有三个属性
 提供三个枚举供外界设置，图片的样式
 */
typedef enum {
    FWPopMenuArrowPostionLeft,
    FWPopMenuArrowPostionCenter,
    FWPopMenuArrowPostionRight
}FWPopMenuArrowPostion;

@protocol FWPopMenuelegate <NSObject>

- (void)popMenuDidDismissed:(FWPopMenu *)popmenu;

@end

@interface FWPopMenu : UIView
/**
 *  设置子控件的frame
 */
- (void)showInRect:(CGRect)rect;

//对象方法init
- (instancetype)initWithContentButton:(UIView *)button;
//类方法
+ (instancetype)popMenuWithContentButton:(UIView *)button;

//代理
@property (nonatomic, strong) id<FWPopMenuelegate> delegate;
/**
 *  创建一个枚举类型的对象
 */
@property (nonatomic, assign) FWPopMenuArrowPostion popMenuArrowPostion;
/**
 *  是否设置遮罩颜色透明度,提供一个属性供外界选择使用，是否有遮罩
    getter=isDismissBackground提供一个getter方法可以赋值给外界属性，获取当前dismissBackground的值，isDismissBackground这个不能被赋值改变，dismissBackground可以
 */
@property (nonatomic, assign, getter=isDismissBackground) BOOL dismissBackground;


@end
