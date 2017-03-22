//
//  KPLocationManager.h
//  KPLive
//
//  Created by kunpeng on 2017/3/20.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)(NSString *longitude, NSString *latitude);

@interface KPLocationManager : NSObject

/**
 *  经度
 */
@property (nonatomic,strong) NSString *longitude;

/**
 *  纬度
 */
@property (nonatomic,strong) NSString *latitude;

/**
 *  单例
 *
 *  @return KPLocationManager实例
 */
+ (instancetype)shareManager;

/**
 *   获取当前经纬度
 *
 *  @param locationBlock Block回调
 */
- (void)getLocation:(LocationBlock)locationBlock;

@end
