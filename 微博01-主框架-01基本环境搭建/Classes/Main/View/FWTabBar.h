//
//  FWTabBar.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/21.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWTabBar;
@protocol FWTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickPlusBtn:(FWTabBar *)tabBar;

@end
@interface FWTabBar : UITabBar


@property (nonatomic, weak) id<FWTabBarDelegate> tabarDelegate;
@end
