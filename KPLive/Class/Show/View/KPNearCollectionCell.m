//
//  KPNearCollectionCell.m
//  KPLive
//
//  Created by kunpeng on 2017/3/20.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPNearCollectionCell.h"

@interface KPNearCollectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@end

@implementation KPNearCollectionCell

- (void)setHotLiveModel:(KPHotLiveModel *)hotLiveModel {

    _hotLiveModel = hotLiveModel;
    [_avatarImageView downloadImage:hotLiveModel.creator.portrait placeholder:@"default_room"];
    _distanceLabel.text = hotLiveModel.distance;
}

- (void)showAnimation {

    if (_hotLiveModel.isShow) { return; }
    self.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    [UIView animateWithDuration:0.5 animations:^{
       
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        _hotLiveModel.show = YES;
    }];
}

@end
