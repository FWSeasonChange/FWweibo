//
//  FWNavigationController.m
//  微博01-主框架-03加入导航
//
//  Created by 付玮 on 15/8/19.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWNavigationController.h"

@implementation FWNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 *  当第一次使用这个类的时候调用，只会调用一次
 */
+(void)initialize
{
    //    设置UIBarButtonItem主题，适用于全部
    [self setBarButtonThem];
    
    //设置UINavigationBar主题
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    NSMutableDictionary *titleColorDict = [NSMutableDictionary dictionary];
//    设置UINavigationBar文字颜色
    titleColorDict[NSForegroundColorAttributeName] = [UIColor blackColor];
//    设置UINavigationBar文字字体大小, 全局常用宏
    titleColorDict[NSFontAttributeName] = FWNavigationBarFont;
//    去除文字阴影
//    不能直接放UIOffsetZero或者UIffsetmake(,)因为titleColorDict是字典只能够放OC对象NS
//    其他都不能放，想要放包装成OC对象,iOS8不建议使用
//    titleColorDict[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
//    新方法默认为空没有阴影
//    titleColorDict[NSShadowAttributeName] = nil;
    [appearance setTitleTextAttributes:titleColorDict];
}
+ (void)setBarButtonThem
{
    
    //    设置UIBarButtonItem主题，适用于全部
    /*
     三种状态只有颜色不相同，可以抽取成一个方法，这里还可以以字典初始化字典，让新的字典拥有前面的属相，重新设置字典的字体属性，新的值会覆盖旧的值
     */
    //    普通状态
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSMutableDictionary *textColorDict = [NSMutableDictionary dictionary];
    textColorDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textColorDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textColorDict forState:UIControlStateNormal];
    
    //    高亮状态
    NSMutableDictionary *highTextColorDict = [NSMutableDictionary dictionaryWithDictionary:textColorDict];
    highTextColorDict[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:highTextColorDict forState:UIControlStateHighlighted];
    
    //    不可用状态
    NSMutableDictionary *disableTextColorDict = [NSMutableDictionary dictionaryWithDictionary:textColorDict];
    disableTextColorDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [appearance setTitleTextAttributes:disableTextColorDict forState:UIControlStateDisabled];
    //    没有用，没有变成灰色，设置太晚了，view先加载Vc.view.backgroundColor = RandomColor;
    //    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    if (iOSVersion < 7.0) {
        //设置UIBarButtonItem背景图片
        [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }


}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    本方法实现隐藏TabBar
    if (self.viewControllers.count > 0) {
        //左按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barBtnWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        //    右按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnWithImageName:@"navigationbar_more" highImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
        //        当第一个控制器进来时viewControllers.count为0不隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //    调用父类的方法实现push控制器操作
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
#warning self就是navigationController
    [self popViewControllerAnimated:YES];
}
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
