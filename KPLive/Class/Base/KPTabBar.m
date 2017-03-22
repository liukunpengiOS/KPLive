//
//  KPTabBar.m
//  KPLive
//
//  Created by kunpeng on 2017/3/15.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPTabBar.h"

@interface KPTabBar ()

@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) UIButton *lastTabBarItem;
@property (nonatomic,strong) UIButton *cameraItem;
@property (nonatomic,strong) UIImageView *tabBarBackgroudImv;
@end

@implementation KPTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [[UITabBar appearance] setShadowImage:[UIImage new]];
        [[UITabBar appearance] setBackgroundImage:[UIImage new]];
        [self addSubview:self.tabBarBackgroudImv];
        [self configTabBarItem];
        [self configCameraItem];
    }
    return self;
}

- (void)configTabBarItem {
    
    for (NSInteger i = 0; i < self.dataList.count; i++) {
        NSString *buttonImage = self.dataList[i];
        NSString *pressButtonImage = [self.dataList[i] stringByAppendingString:@"_p"];
        UIButton *tabBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        tabBarItem.adjustsImageWhenHighlighted = NO;
        tabBarItem.tag = KPItemTypeLive + i;
        [tabBarItem setImage:[UIImage imageNamed:buttonImage] forState:UIControlStateNormal];
        [tabBarItem setImage:[UIImage imageNamed:pressButtonImage] forState:UIControlStateSelected];
        [tabBarItem addTarget:self action:@selector(tabBarItemEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tabBarItem];
        
        if (i == 0) {
            tabBarItem.selected = YES;
            _lastTabBarItem = tabBarItem;
        }
    }
}

- (UIButton *)configCameraItem {
    
    if (!_cameraItem) {
        _cameraItem = ({
            UIButton *cameraItem = [UIButton buttonWithType:UIButtonTypeCustom];
            cameraItem.tag = KPItemTypeLaunch;
            [cameraItem setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
            [cameraItem addTarget:self action:@selector(tabBarItemEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cameraItem];
            cameraItem;
        });
    }
    return _cameraItem;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tabBarBackgroudImv.frame = self.bounds;
    CGFloat width = self.bounds.size.width / self.dataList.count;
    for (NSInteger i = 0; i < [self subviews].count; i++) {
        
        UIView *buttonView = [self subviews][i];
        if ([buttonView isKindOfClass:[UIButton class]]) {
         
            buttonView.frame = CGRectMake((buttonView.tag - KPItemTypeLive) * width,
                                          0, width, self.frame.size.height);
        }
    }
    //设置直播按钮的frame，以下代码顺序不能变，否则位置不正确
    [_cameraItem sizeToFit];
    _cameraItem.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 50);
}

- (UIImageView *)tabBarBackgroudImv {
    
    if (!_tabBarBackgroudImv) {
        _tabBarBackgroudImv = ({
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:
                                      [UIImage imageNamed:@"global_tab_bg"]];
            imageView;
        });
    }
    return _tabBarBackgroudImv;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        
        _dataList = @[@"tab_live",@"tab_me"];
    }
    return _dataList;
}

- (void)tabBarItemEvent:(UIButton *)tabBarItem {
    
    //delegate 回调
    if ([_delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        [_delegate tabbar:self clickButton:tabBarItem.tag];
    }
    //block 回调
    !self.tabBlock ?: self.tabBlock(self,tabBarItem.tag);
    //如果点击的是‘启动直播’不执行下面的代码
    if (tabBarItem.tag == KPItemTypeLaunch) { return; }
    //点击选中状态切换
    _lastTabBarItem.selected = NO;
    tabBarItem.selected = YES;
    _lastTabBarItem = tabBarItem;
    //点击动画
    [UIView animateWithDuration:0.2 animations:^{
        
        tabBarItem.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            
            tabBarItem.transform = CGAffineTransformIdentity;
        }];
    }];
}

//重新父类方法让超出父视图的子控件响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            
            CGPoint touchPoint = [subView convertPoint:point fromView:self];
            
            if (CGRectContainsPoint(subView.bounds, touchPoint)) {
                
                view = subView;
            }
        }
    }
    return view;
}

@end
