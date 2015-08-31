//
//  FWTextView.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/28.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWTextView.h"

@interface FWTextView ()



@end

@implementation FWTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [self addSubview:label];
        self.placeholderLabel = label;
        
        /*
            label是自己的子控件操作它就在这个文件，但是自己成为自己的代理，不符合代理的设计思想不建议使用，代理只有一份，当文件想要设置这个代理时，就会覆盖
         
            想要监听控件状态的改变有以下三种方法
         1.代理delegate
         2.addTaget方法，只适用于继承自UIControl的控件
         3.通知，有一些控件状态改变时，会有代理方法通知代理，也会发出通知
         
         UITextViewTextDidChangeNotification
         在UITextView里面文字改变发出的通知,只有当用户手动改变文字是才会发送通知，代码改变不会
         这里重写setText方法监听文字的代码改变
         
         
         状态的改变分为模拟器，手机改变和代码改变注意区别
        */

//        self.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        
        //        设置默认提示文字颜色
        self.placeholderColor = [UIColor lightGrayColor];
        
        //        设置文字大小
        /*
         占位文字大小可以在外部文件设置这里会产生字体不一致需要重写setFont方法来监听外界设置的字体大小来保持与编辑文字一致
         */
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}
#pragma mark - 通知方法
- (void)textDidChange
{
    self.placeholderLabel.hidden = self.text.length != 0;
}


- (void)setText:(NSString *)text
{
//    调用父类方法设置文字此方法就是父类的，子类重写了就会覆盖不会自动掉用父类方法,所以手动调用
    [super setText:text];
    
    [self textDidChange];
}

-(void)setPlaceholder:(NSString *)placeholder
{
#warning 如果是copy最好这样写
//    _placeholder = [placeholder copy];
    _placeholder = placeholder;
    //    设置提示文字
    self.placeholderLabel.text = placeholder;
    
//    设置文字后重新布局一次,就是重新计算子控件位置
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    //    调用super方法是设置编辑文字的大小，这个类继承自UITextView这个属性就是父类的
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    //    设置文字自提后重新布局一次,就是重新计算子控件位置，所有影响子控件位置布局的设置都在设置的里面重新布局
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = _placeholderColor;
    
}

/**
 *  设置子控件frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat labelX = 5;
    CGFloat labelY = 8;
    CGFloat labelW = self.width - 2 * labelX;
    
    //    根据文字计算高度
    
    CGSize maxSize = CGSizeMake(labelW, MAXFLOAT);
    
    CGFloat labelH = [self.placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:maxSize].height;
    
    //    [self.placeholder boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
    self.placeholderLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
}



@end
