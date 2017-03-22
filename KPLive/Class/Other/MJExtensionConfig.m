//
//  MJExtensionConfig.m
//  KPLive
//
//  Created by kunpeng on 2017/3/17.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "KPCreator.h"
#import "KPHotLiveModel.h"

@implementation MJExtensionConfig

/**
 *  这个方法会在MJEXtensionConfig加载进内存之后调用一次
 */
+ (void)load {
    
#pragma mark - 如果使用NSObject调用这些方法，代表所有继承自NSObject的子类都会生效
#pragma mark - NSObject中的ID属性对应着字典中的id
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{@"ID": @"id"};
    }];
    
    [KPCreator mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{@"desc": @"description"};
    }];
    
#pragma mark - KPShow的所有驼峰属性转成下划线key字典中取值
    [KPHotLiveModel mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        
        return [propertyName mj_underlineFromCamel];
    }];
}

@end
