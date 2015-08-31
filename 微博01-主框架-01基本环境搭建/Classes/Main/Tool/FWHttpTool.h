//
//  FWHttpTool.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/31.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWHttpTool : NSObject

/*
此处不能返回服务器字典，因为是同步请求,服务器返回字典需要时间，调用方法立即返回就会卡住，费时操作在子线程中执行，通过block返回主线程返回数据
 */

/**
*  @param success 成功发送调用block代码(void (^)(id respoenObj))success
 success:block代码名
 void:无返回值
 (^):block代码
 (id respoenObj):带有一个id类型的respoenObj参数，传值respoenObj可以不写
*  @param falier  失败返回
*/

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id respoenObj))success failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

@end
