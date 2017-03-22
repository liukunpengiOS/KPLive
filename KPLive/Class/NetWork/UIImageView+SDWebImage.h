//
//  UIImageView+SDWebImage.h
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^downloadSuccessBlock)(UIImage *image);
typedef void(^downloadFailureBlock)(NSError *error);
typedef void(^downloadProgressBlock)(CGFloat progress);

@interface UIImageView (SDWebImage)

/**
 *  异步加载图片
 *
 *  @param url         图片地址
 *  @param placeholder 占位图片名
 */
- (void)downloadImage:(NSString *)url placeholder:(NSString *)placeholder;

/**
 *  异步加载图片，可以监听下载进度，成功或失败
 *
 *  @param url         图片地址
 *  @param placeholder 占位图片名
 *  @param success     下载成功
 *  @param failure     下载失败
 *  @param progress    下载进度
 */
- (void)downloadImage:(NSString *)url
          placeholder:(NSString *)placeholder
              success:(downloadSuccessBlock)success
              failure:(downloadFailureBlock)failure
             progress:(downloadProgressBlock)progress;
@end
