//
//  FWStatesModel.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/27.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWStatesModel.h"
#import "MJExtension.h"
#import "FWPictueModel.h"
@implementation FWStatesModel
/**
 *   将数组中的的元素设置为FWPictueModel对象类型
    设置数组中的对象类型
 */
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [FWPictueModel class]};
}


@end
