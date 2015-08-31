//
//  FWStatesModel.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/27.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWUserModel.h"
@interface FWStatesModel : NSObject
#warning 这里的属性都根据服务商返回的JSON或者XML本地打印出来的来设置

/**
 *	string	微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/**string	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

/**object	微博作者的用户信息字段*/
@property (nonatomic, strong) FWUserModel  *user;

/**object	被转发的原微博信息字段，当该微博为转发微博时返回*/
@property (nonatomic, strong) FWStatesModel  *retweeted_status;

/**int	转发数*/
@property (nonatomic, assign) NSInteger reposts_count;

/**int	评论数*/
@property (nonatomic, assign) NSInteger comments_count;

/**int	表态数*/
@property (nonatomic, assign) NSInteger attitudes_count;

/**	string	缩略图片地址，没有时不返回此字段*/
@property (nonatomic, copy) NSString *thumbnail_pic;

/**	object	微博配图url。*/
@property (nonatomic, strong) NSArray  *pic_urls;


@end
