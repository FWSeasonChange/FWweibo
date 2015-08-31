//
//  FWAccountModel.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/26.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWAccountModel : NSObject<NSCoding>

/**
 *  用于调用access_token，接口获取授权后的access token。
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  access_token的生命周期，单位是秒数。
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  过期时间
 */
@property (nonatomic, strong) NSDate *expires_time;

/**
 *  当前授权用户的UID。
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  用户名
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
