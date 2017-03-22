//
//  KPNearCollectionCell.h
//  KPLive
//
//  Created by kunpeng on 2017/3/20.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPHotLiveModel.h"

@interface KPNearCollectionCell : UICollectionViewCell

@property (nonatomic,strong) KPHotLiveModel *hotLiveModel;

- (void)showAnimation;

@end
