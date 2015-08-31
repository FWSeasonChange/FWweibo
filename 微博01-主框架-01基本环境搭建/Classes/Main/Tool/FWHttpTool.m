//
//  FWHttpTool.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/31.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWHttpTool.h"
#import "AFNetworking.h"

@implementation FWHttpTool

/**
 *  get请求
 */
+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
        //    1.获得请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
        //    2.发送请求
        [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id  responseObj) {
//            block代码不能为空
            if (success) {
                success(responseObj);
            }
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(failure)
            {
                failure(error);
            }
        }];
}

/**
 *  post请求
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //    1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

//    2.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id  responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
