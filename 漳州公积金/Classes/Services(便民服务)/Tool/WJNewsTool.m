//
//  WJNewsTool.m
//  漳州公积金
//
//  Created by fengwujie on 16/1/8.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJNewsTool.h"
#import "MJExtension.h"
#import "WJHttpTool.h"

@implementation WJNewsTool


+ (void)newsWithParam:(WJNewsParam *)param success:(void (^)(WJNewsReturn *))success failure:(void (^)(NSError *))failure
{
    
//    // 从数据库中读取（加载）缓存数据(微博模型数组)
//    NSArray *cachedHomeStatuses = [self cachedHomeStatusesWithParam:param];
//    if (cachedHomeStatuses.count != 0) { // 有缓存数据
//        if (success) {
//            HMHomeStatusesResult *result = [[HMHomeStatusesResult alloc] init];
//            result.statuses = cachedHomeStatuses;
//            success(result);
//        }
//    } else { // 没有缓存数据
        NSDictionary *params = [param mj_keyValues];
        
        [WJHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responseObj) {
            // 新浪返回的字典数组
//            NSArray *statusDictArray = responseObj[@"statuses"];
            
            // 缓存微博字典数组
//            [self saveHomeStatusDictArray:statusDictArray accessToken:param.access_token];
            
            if (success) {
                WJNewsReturn *result = [WJNewsReturn mj_objectWithKeyValues:responseObj];
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
//    }

}


@end
