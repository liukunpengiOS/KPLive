//
//  KPTabBarController.m
//  KPLive
//
//  Created by kunpeng on 2017/3/15.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPTabBarController.h"
#import "KPLaunchController.h"
#import "KPNavigationController.h"
#import "KPTabBar.h"

@interface KPTabBarController ()<KPTabBarDelegate>

@property (nonatomic,strong) KPTabBar *kpTabBar;
@end

@implementation KPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configControllers];
    [self.tabBar addSubview:[self kpTabBar]];
}

- (void)configControllers {
    
    NSMutableArray *controllerArray = [NSMutableArray arrayWithArray:@[@"KPShowController",@"KPMeController"]];
    for (NSInteger i = 0; i < controllerArray.count; i++) {
        
        NSString *controllerName = controllerArray[i];
        UIViewController *controller = [[NSClassFromString(controllerName) alloc] init];
        KPNavigationController *navigationController = [[KPNavigationController alloc]
                                                        initWithRootViewController:controller];
        [controllerArray replaceObjectAtIndex:i withObject:navigationController];
    }
    self.viewControllers = controllerArray;
}

- (KPTabBar *)kpTabBar {
    
    if (!_kpTabBar) {
        _kpTabBar = ({
            KPTabBar *tabBar = [[KPTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
            tabBar.delegate = self;
            tabBar;
        });
    }
    return _kpTabBar;
}

#pragma mark - KPTabBarDelegate

- (void)tabbar:(KPTabBar *)tabbar clickButton:(KPItemType)itemType {
    
    if (itemType != KPItemTypeLaunch) {
        self.selectedIndex = itemType - KPItemTypeLive;
        return;
    }
    
    KPLaunchController *launchController = [[KPLaunchController alloc] init];
    [self presentViewController:launchController animated:YES completion:nil];
}

@end
