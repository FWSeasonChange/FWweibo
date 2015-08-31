//
//  FWFooterView.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/28.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWFooterView.h"

@implementation FWFooterView

+ (instancetype)footerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FWFooterView" owner:nil options:nil] lastObject];
}

@end
