//
//  TabBarViewController.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/18.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MessageTableController.h"
#import "DiscoverViewController.h"
#import "ProfileTableController.h"
#import "FWNavigationController.h"
#import "FWTabBar.h"
#import "FWComposeViewController.h"

@interface TabBarViewController ()<FWTabBarDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    创建四个子控制器
    [self setAllChildVcs];
    
//    创建自定义tabBar
    [self setCoustomTabBar];
}

/**
 *  创建自定义tabBar
 */
- (void)setCoustomTabBar
{
    //    通过KVC更换系统自带的TabBar，因为系统自带的TabBar是readonly
    /**
     *  kVC:原理找到对应键的_的值设置，不会调用setter方法
     */
    FWTabBar *customTabBar = [[FWTabBar alloc]init];
//    设置控制器为自定义tabBar的代理
    customTabBar.tabarDelegate = self;
    
    //    设置系统的TabBar为自定义的TabBar
    [self setValue:customTabBar forKey:@"tabBar"];
}

/**
 *  FWTabBar的代理方法实现控制器切换
 */
- (void)tabBarDidClickPlusBtn:(FWTabBar *)tabBar
{
    FWComposeViewController *compose = [[FWComposeViewController alloc]init];
//    包装一个navigationController控制器
    FWNavigationController *composeNav = [[FWNavigationController alloc]initWithRootViewController:compose];
//  modal出一个控制器
    [self presentViewController:composeNav animated:YES completion:nil];
    
}


/**
 *  创建四个子控制器
 */
- (void)setAllChildVcs
{
    //    添加子控制器
    UIViewController *home = [[HomeViewController alloc]init];
    [self setChildVc:home title:@"首页" image:@"tabbar_home_os7" selectedImage:@"tabbar_home_selected_os7"];
    
    UIViewController *message = [[MessageTableController alloc]init];
    [self setChildVc:message title:@"消息" image:@"tabbar_message_center_os7" selectedImage:@"tabbar_message_center_selected_os7"];
    
    UIViewController *discover = [[DiscoverViewController alloc]init];
    [self setChildVc:discover title:@"发现" image:@"tabbar_discover_selected_os7" selectedImage:@"tabbar_discover_selected_os7"];
    
    UIViewController *me = [[ProfileTableController alloc]init];
    [self setChildVc:me title:@"我" image:@"tabbar_profile_os7"  selectedImage:@"tabbar_profile_selected_os7"];
}

- (void)changeTabBarLabelColor
{
    /**
     *  1.遍历self.tabBar的子控件判断是UITabBarButton
     2.遍历UITabBarButton的子控件找到UITabBarButtonLabel它是继承自UILabel
     3.改变颜色,目前我无法判断当前选中状态
     */
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *childchild in child.subviews) {
                if ([childchild isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
                    UILabel *label = (UILabel *)childchild;
                    [label setTextColor:[UIColor orangeColor]];
                }
            }
        }
    }
}
/**
 *  思考过程方法，废弃
 */
- (void)removeTabBarSelectionView
{
    //    再view显示完毕之后打印UITabBar的子控件
    /**
     *  有6个子控件
     4个UITabBarButton
     1个_UITabBarBackgroundView
     1个UIImageView
     尝试使用UITabBarButton发现并没有这个类，因为这个类是私有的不能用
     继续打印这些类的父类
     发现UITabBarButton继承自UIControl
     查看UIControl方法只有setBackground和setBounds方法没有有设置图片的方法
     猜测按钮背景可能是颜色没有用
     继续尝试打印UITabBar的子控件的子控件
     发现有UITabBarSwappableImageView和UITabBarButtonLabel尝试设置
     iOS6还有一个UITabBarSelectionIndicatorView,的按钮按下去的背景，iOS7以后已经移除
     再iOS6中需要手动移除，监听UITabBarButton点击事件，
     */
    //    UIControl *control;
    //    FWLog(@"%@", self.tabBar.subviews);
    //    UITabBarButton
    //    先遍历子类
    //        逐个打印子控件的父类
    //        FWLog(@"%@", child.superclass);
    //        没用
    //        child.backgroundColor = [UIColor clearColor];
    //
    for (UIView *child in self.tabBar.subviews) {
        //        如果不是UITabBarButton就过掉这次循环
        if (![child isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        //        设置默认选中状态为NO
        BOOL selected = NO;
        FWLog(@"%@", child.subviews);
        for (UIView *childchild in child.subviews) {
            FWLog(@"%@", childchild);
            if ([childchild isKindOfClass:NSClassFromString(@"UITabBarSelectionIndicatorView")]) {
                [childchild removeFromSuperview];
                //                处于选中状态
                selected = YES;
            }
            if ([childchild isKindOfClass:[UILabel class]]) {//如果是UILabel
                UILabel *label = (UILabel *)childchild;
                if (selected) {//如果是选中状态设置为橙色
                    [label setTextColor:[UIColor orangeColor]];
                }
                else//没选中
                {
                    [label setTextColor:[UIColor blackColor]];
                    
                }
            }
        }
    }
}

/**
 *  tabBar添加子控制器
 *
 *  @param Vc                 子控制器
 *  @param title              tabBarItem标题
 *  @param imageNamed         默认图片名
 *  @param selectedImageNamed 选中图片名
 */
- (void)setChildVc:(UIViewController *)Vc title:(NSString *)title image:(NSString *)imageNamed selectedImage:(NSString *)selectedImageNamed
{
    //    随机色
    //    Vc.view.backgroundColor = RandomColor;
    Vc.title = title;
    Vc.tabBarItem.image = [UIImage imageWithName:imageNamed];
    UIImage *selectedImage = [UIImage imageWithName:selectedImageNamed];
    
//    设置tabBarItem的文字颜色,普通状态
    NSMutableDictionary *norTextColor = [NSMutableDictionary dictionary];
    norTextColor[UITextAttributeTextColor] = [UIColor blackColor];
    [Vc.tabBarItem setTitleTextAttributes:norTextColor forState:UIControlStateNormal];
    
//    选中状态为橙色
    NSMutableDictionary *selTextColor = [NSMutableDictionary dictionary];
    selTextColor[UITextAttributeTextColor] = [UIColor orangeColor];
    [Vc.tabBarItem setTitleTextAttributes:selTextColor forState:UIControlStateSelected];
    
    //    判断当前iOS版本
    if(iOSVersion >= 7.0){
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    Vc.tabBarItem.selectedImage = selectedImage;
    //    让控制器归navigationController管
    FWNavigationController *nav = [[FWNavigationController alloc]initWithRootViewController:Vc];
    [self addChildViewController:nav];
}


@end
