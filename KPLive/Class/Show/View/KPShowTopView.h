//
//  KPShowTopView.h
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^showTopBlock)(NSInteger tag);
@interface KPShowTopView : UIView

@property (nonatomic,copy) showTopBlock showTopBlock;

- (instancetype)initWithFrame:(CGRect)frame tilteNames:(NSArray *)titles;

- (void)scrolling:(NSInteger)tag;

@end
