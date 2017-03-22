//
//  KPShowHandler.m
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPShowHandler.h"
#import "AFHttpTool.h"
#import "KPHotLiveModel.h"
#import "KPAdvertise.h"
#import "KPLocationManager.h"

@implementation KPShowHandler

+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success
                                 failure:(FailureBlock)failure {

    [AFHttpTool getWithPath:API_LiveGetTop parameters:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failure(json);
        }else {
            //数据解析
            NSArray *lives= [KPHotLiveModel mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success
                                  failure:(FailureBlock)failure {
    
    KPLocationManager *locationManager = [KPLocationManager shareManager];
    NSDictionary *parameter = @{@"uid":@"85149891",
                                @"longitude":locationManager.longitude,
                                @"latitude":locationManager.latitude};
    [AFHttpTool getWithPath:API_NearLocation parameters:parameter success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failure(json);
        }else {
            //数据解析
            NSArray *lives= [KPHotLiveModel mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);
        }
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

+ (void)executeGetAdTaskWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure {

    [AFHttpTool getWithPath:API_Advertise parameters:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failure(json);
        }else {
            //数据解析
            KPAdvertise *advertise = [KPAdvertise mj_objectWithKeyValues:json[@"resources"][0]];
            success(advertise);
        }
    } failure:^(NSError *error) {
       
        failure(error);
    }];
}

@end
