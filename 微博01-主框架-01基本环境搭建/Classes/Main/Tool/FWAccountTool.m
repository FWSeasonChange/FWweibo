//
//  FWAccountTool.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/26.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

//    设置存储路径
#define filePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.data"]

#import "FWAccountTool.h"
#import "FWAccountModel.h"

@implementation FWAccountTool
+ (void)saveAccount:(FWAccountModel *)account
{

//    把account存储到filePath路径对应的文件里面
//    归档NSKeyedArchiver需要对应存储的数据类型FWAccountModel遵循NSCoding协议
//    并且实现initWithCoder:和enCodeWithCoder:
//    归档，存储
    [NSKeyedArchiver archiveRootObject:account toFile:filePath];
    
}
+ (FWAccountModel *)getAccount
{
    
//    解档，获取数据
    FWAccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

//    到达过期时间就需要重新登录授权，再创建数据时获取存储的是时间加上expires_in就是过期时间
    NSDate *now = [NSDate date];
    if ([now compare:account.expires_time] !=
NSOrderedAscending) {
//        过期就没有数据
        return nil;
    }
    return account;
}

@end
