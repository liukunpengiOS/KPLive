//
//  KPAvatorInfoView.m
//  KPLive
//
//  Created by kunpeng on 2017/3/17.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPHotAvatorView.h"
#import "UIImageView+Corner.h"

@interface KPHotAvatorView ()

@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UILabel *onLineUserLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UIImageView *avatarImv;
@end

@implementation KPHotAvatorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configElements];
    }
    return self;
}

- (void)configElements {
    
    [self configAvatarImv];
    [self configNickLabel];
    [self configLocationLabel];
    [self configOnLineUserLabel];
    [self configStatusLabel];
}

- (void)configAvatarImv {
    
    if (!_avatarImv) {
        _avatarImv = ({
        
            UIImageView *imageView = [UIImageView cornerImageView:CGRectMake(10, 0, 50, 50)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:imageView];
            imageView;
        });
    }
}

- (void)configNickLabel {
    
    if (!_nickLabel) {
        _nickLabel = ({
            
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.equalTo(_avatarImv.mas_right).offset(10);
                make.top.equalTo(self);
                make.width.offset(150);
            }];
            label;
        });
    }
}

- (void)configLocationLabel {

    if (!_locationLabel) {
        _locationLabel = ({

            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:15];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.equalTo(_nickLabel);
                make.bottom.equalTo(_avatarImv);
                make.width.offset(100);
            }];
            label;
        });
    }
}

- (void)configOnLineUserLabel {
    
    if (!_onLineUserLabel) {
        _onLineUserLabel = ({
        
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentRight;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(self);
                make.right.offset(-10);
                make.width.offset(100);
            }];
            label;
        });
    }
}

- (void)configStatusLabel {
    
    if (!_statusLabel) {
        _statusLabel = ({
        
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:15];
            label.text = @"在看";
            [label sizeToFit];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.bottom.equalTo(self);
                make.right.equalTo(_onLineUserLabel);
            }];
            label;
        });
    }
}

- (void)setHotLiveModel:(KPHotLiveModel *)hotLiveModel {

    _nickLabel.text = hotLiveModel.creator.nick;
    _locationLabel.text = hotLiveModel.city ?: @"在火星";
    
    _onLineUserLabel.text = [@(hotLiveModel.onlineUsers) stringValue];
    if ([hotLiveModel.creator.portrait isEqualToString:@"kunpeng.JPG"]) {
        _avatarImv.image = [UIImage imageNamed:@"kunpeng.JPG"];
        return;
    }
    [_avatarImv downloadImage:hotLiveModel.creator.portrait
                  placeholder:@"default_room"];
}
@end
