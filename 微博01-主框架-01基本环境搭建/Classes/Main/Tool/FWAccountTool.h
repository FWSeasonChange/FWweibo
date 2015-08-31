//
//  FWAccountTool.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/26.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FWAccountModel.h"

@interface FWAccountTool : NSObject
/**
 *  保存模型账号数据
 */
+ (void)saveAccount:(FWAccountModel *)account;

+ (FWAccountModel *)getAccount;

@end
