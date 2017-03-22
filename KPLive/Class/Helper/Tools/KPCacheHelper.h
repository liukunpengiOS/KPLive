//
//  KPCacheHelper.h
//  KPLive
//
//  Created by kunpeng on 2017/3/21.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPCacheHelper : NSObject

/**
 *  获取广告
 *
 *  @return 广告数据
 */
+ (NSString *)getAdvertise;

/**
 *  保存广告
 *
 *  @param image 需要保存的广告数据
 */
+ (void)setAdvertise:(NSString *)image;

@end
