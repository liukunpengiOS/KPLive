//
//  UIImageView+SDWebImage.m
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "UIImageView+SDWebImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SDWebImage)

- (void)downloadImage:(NSString *)url placeholder:(NSString *)placeholder {

    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:[UIImage imageNamed:placeholder]
                     options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

- (void)downloadImage:(NSString *)url
          placeholder:(NSString *)placeholder
              success:(downloadSuccessBlock)success
              failure:(downloadFailureBlock)failure
             progress:(downloadProgressBlock)progress {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:[UIImage imageNamed:placeholder]
                     options:SDWebImageRetryFailed | SDWebImageLowPriority
                    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
                        progress(receivedSize * 1.0 / expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
            failure(error);
        }else {
            
            self.image = image;
            success(image);
        }
    }];
}

@end
