//
//  WJNewsParam.h
//  漳州公积金
//
//  Created by fengwujie on 16/1/8.
//  Copyright © 2016年 vision-soft. All rights reserved.
//  新闻请求参数模型

#import <Foundation/Foundation.h>

@interface WJNewsParam : NSObject

/**	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。*/
@property (nonatomic, strong) NSNumber *since_id;

/** false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。*/
@property (nonatomic, strong) NSNumber *max_id;

/** false	int	单页返回的记录条数，最大不超过100，默认为20。*/
@property (nonatomic, strong) NSNumber *count;

+ (instancetype)param;
@end
