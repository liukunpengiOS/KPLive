//
//  AFHttpClient.h
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)shareClient;

@end
