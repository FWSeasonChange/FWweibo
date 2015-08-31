//
//  FWTextView.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/28.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWTextView : UITextView

/** 外界可设置提示文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 显示提示文字Label */
@property (nonatomic, weak) UILabel *placeholderLabel;

/** 外界可以设置提示文字颜色 */
@property (nonatomic, weak) UIColor *placeholderColor;


@end
