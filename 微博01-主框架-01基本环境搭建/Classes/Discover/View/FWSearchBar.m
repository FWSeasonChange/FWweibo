//
//  FWSearchBar.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/20.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWSearchBar.h"

@implementation FWSearchBar

//自定义控件早initWithframe里面设置，init方法会调用initWithframe方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //    UISearchVBar有局限性，用UITextField好
        //   宽高自己设置
        //    searchBar.width = 300;
        //    searchBar.height = 30;
        //    图片
        self.background = [UIImage resizeWithImage:@"searchbar_textfield_background"];
        //    文字居中
        /*
         UITextField没有垂直居中的属性textAlignment是水平居中
         想要这个属性，本类没有就去父类的去找，再没有就去父类的父类。。。
         再父类UIControl里面有一个contentVerticalAlignment
         Vertical垂直
         */
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //    设置左边显示放大镜
        UIImage *image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
        UIImageView *leftImage = [[UIImageView alloc]init];
        leftImage.image = image;
        //    让图显示到合适的位置，先把leftView的范围扩大，再让给图片居中
        //    leftimageView的范围比图片宽一点
        leftImage.width = image.size.width + 10;
        leftImage.height = image.size.height;
        //    图片居中
        leftImage.contentMode = UIViewContentModeCenter;
        self.leftView = leftImage;
        //    设置textFiled的view的显示模式，因为默认为Never
        self.leftViewMode = UITextFieldViewModeAlways;
        //    设置显示清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;

        
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc]init];
}


@end
