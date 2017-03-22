//
//  KPTabBar.h
//  KPLive
//
//  Created by kunpeng on 2017/3/15.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KPItemType) {
    
    KPItemTypeLaunch = 200,  //启动直播
    KPItemTypeLive = 100, //展示直播
    KPItemTypeMe     //我的
};

@class KPTabBar;

typedef void(^TabBlock)(KPTabBar *tabbar, KPItemType type);

@protocol KPTabBarDelegate <NSObject>

- (void)tabbar:(KPTabBar *)tabbar clickButton:(KPItemType)type;

@end

@interface KPTabBar : UIView

@property (nonatomic,weak) id <KPTabBarDelegate> delegate;

@property (nonatomic,copy) TabBlock tabBlock;

@end
