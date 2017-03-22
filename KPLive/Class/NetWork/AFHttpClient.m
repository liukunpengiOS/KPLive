//
//  AFHttpClient.m
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "AFHttpClient.h"

@implementation AFHttpClient

+ (instancetype)shareClient {
    static AFHttpClient *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:SERVER_HOST]
                                  sessionConfiguration:configuration];
        //接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",
                                                            @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //超时时间
        client.requestSerializer.timeoutInterval = 15;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    return client;
}
@end
