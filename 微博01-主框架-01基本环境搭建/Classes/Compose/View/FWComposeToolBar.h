//
//  FWComposeToolBar.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/29.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FWComposeToolBar;


typedef enum {
    FWComposeToolBarButtonTypeCamera, //相机
    FWComposeToolBarButtonTypePicture,  //图片
    FWComposeToolBarButtonTypeMention, //@
    FWComposeToolBarButtonTypeTrend,    //话题
    FWComposeToolBarButtonTypeEmotion,   //表情
}FWComposeToolBarButtonType;

@protocol FWComposeToolBarDeleagte <NSObject>

@optional
- (void)composeToolBar:(FWComposeToolBar *)composeToolBar didClickBtnTag:(FWComposeToolBarButtonType )composeToolBarButtonType;

@end

@interface FWComposeToolBar : UIView

@property (nonatomic, strong) id<FWComposeToolBarDeleagte> delegate;



@end
