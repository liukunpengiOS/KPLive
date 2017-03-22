//
//  KPBaseHandler.h
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  处理完成事件
 */
typedef void(^CompleteBlock)();

/**
 *  处理成功事件
 *
 *  @param obj 返回数据
 */
typedef void(^SuccessBlock)(id obj);

/**
 *  处理失败事件
 *
 *  @param obj 错误信息
 */
typedef void(^FailureBlock)(id obj);


@interface KPBaseHandler : NSObject

@end
