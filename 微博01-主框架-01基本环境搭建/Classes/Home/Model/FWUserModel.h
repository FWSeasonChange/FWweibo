//
//  FWUserModel.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/27.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWUserModel : NSObject
/*
 id	int64	用户UID
 idstr	string	字符串型的用户UID
 screen_name	string	用户昵称
 profile_image_url	string	用户头像地址（中图），50×50像素
 name	string	友好显示名称
 province	int	用户所在省级ID
 city	int	用户所在城市ID
 location	string	用户所在地
 description	string	用户个人描述
 url	string	用户博客地址
 avatar_large	string	用户头像地址（大图），180×180像素
 avatar_hd	string	用户头像地址（高清），高清头像原图
 */
/**
*  友好显示名称
*/
@property (nonatomic, copy) NSString *name;
/**
 *   	string	用户昵称
 */
@property (nonatomic, copy) NSString *screen_name;

/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *profile_image_url;



@end
