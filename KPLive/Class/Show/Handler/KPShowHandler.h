//
//  KPShowHandler.h
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPBaseHandler.h"

@interface KPShowHandler : KPBaseHandler

/**
 *  获取热门直播信息
 *
 *  @param success 获取成功
 *  @param failure 获取失败
 */
+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success
                                 failure:(FailureBlock)failure;

/**
 *  获取附近直播信息
 *
 *  @param success 获取成功
 *  @param failure 获取失败
 */
+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success
                                  failure:(FailureBlock)failure;

/**
 *  获取广告页信息
 *
 *  @param success 获取成功
 *  @param failure 获取失败
 */
+ (void)executeGetAdTaskWithSuccess:(SuccessBlock)success
                            failure:(FailureBlock)failure;
@end
