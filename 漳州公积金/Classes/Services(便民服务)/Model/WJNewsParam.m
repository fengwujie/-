//
//  WJNewsParam.m
//  漳州公积金
//
//  Created by fengwujie on 16/1/8.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJNewsParam.h"

@implementation WJNewsParam

- (NSNumber *)count
{
    return _count ? _count : @20;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end
