//
//  KPCacheHelper.m
//  KPLive
//
//  Created by kunpeng on 2017/3/21.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPCacheHelper.h"

#define advertiseImage @"advertiseImage"
@implementation KPCacheHelper

+ (NSString *)getAdvertise {
 
    return [[NSUserDefaults standardUserDefaults] objectForKey:advertiseImage];
}

+ (void)setAdvertise:(NSString *)image {
    
    [[NSUserDefaults standardUserDefaults] setObject:image forKey:advertiseImage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
