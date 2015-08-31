//
//  FWAccountModel.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/26.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWAccountModel.h"

@implementation FWAccountModel

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
//    保存成模型
    FWAccountModel *account = [[self alloc]init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
//    返回所有字典数据保存好的模型
    return account;
}

/**
 *  当从文件中解析读取一个对象时调用
 *  中有在这里设置的属性可以被解析读取
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
//        从归档文件中解析key值为access_token的数据赋值给self.access_token
        self.access_token = [coder decodeObjectForKey:@"access_token"];
        self.expires_in = [coder decodeObjectForKey:@"expires_in"];
        self.uid = [coder decodeObjectForKey:@"uid"];
        self.name = [coder decodeObjectForKey:@"name"];
//        计算过期时间
//        获取当前时间
        NSDate *now = [NSDate date];
//        加上生命周期expires_in
        self.expires_time = [now dateByAddingTimeInterval:self.expires_in.doubleValue];

    }
    return self;
}

/**
 *  数据模型写入文件时调用
 *  设置存储哪些属性和怎样存储属性
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
//    存入self.access_token属性设置的key是access_token
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.name forKey:@"name"];

}

@end
