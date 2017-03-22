//
//  KPHttpTool.h
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id json);
typedef void(^failureBlock)(NSError *error);
typedef void(^downloadProgressBlock)(CGFloat progress);
typedef void(^uploadProgressBlock)(CGFloat progress);

@interface AFHttpTool : NSObject

/**
 *  GET 请求
 *
 *  @param path       url 地址
 *  @param parameters 请求参数 NSDictionary 类型
 *  @param success    请求成功 返回NSDictionary或NSArray
 *  @param failure    请求失败 返回NSError
 */
+ (void)getWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(successBlock)success
            failure:(failureBlock)failure;

/**
 *  POST 请求
 *
 *  @param path       url 地址
 *  @param parameters 请求参数 NSDictionary 类型
 *  @param success    请求成功 返回NSDictionary或NSArray
 *  @param failure    请求失败 返回NSError
 */
+ (void)postWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(successBlock)success
             failure:(failureBlock)failure;

/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param success  下载成功
 *  @param failure  下载失败
 *  @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path
                 success:(successBlock)success
                 failure:(failureBlock)failure
                progress:(downloadProgressBlock)progress;

/**
 *  上传图片
 *
 *  @param path     url地址
 *  @param image    UIImage对象
 *  @param imageKey imagekey
 *  @param parameters   上传参数
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */
+ (void)uploadImageWithPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                   imageKey:(NSString *)imageKey
                      image:(UIImage *)image
                    success:(successBlock)success
                    failure:(failureBlock)failure
                   progress:(uploadProgressBlock)progress;
@end
