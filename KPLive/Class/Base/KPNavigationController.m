//
//  KPNavigationController.m
//  KPLive
//
//  Created by kunpeng on 2017/3/15.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPNavigationController.h"

@interface KPNavigationController ()

@end

@implementation KPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationBar.barTintColor = RGB(0, 216, 201);
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
}

@end
