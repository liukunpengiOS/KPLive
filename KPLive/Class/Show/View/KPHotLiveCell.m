//
//  KPHotLiveCell.m
//  KPLive
//
//  Created by kunpeng on 2017/3/17.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPHotLiveCell.h"
#import "KPHotAvatorView.h"

@interface KPHotLiveCell ()

@property (nonatomic,strong) UIImageView *coverImv;
@property (nonatomic,strong) UIImageView *liveImv;
@property (nonatomic,strong) KPHotAvatorView *avatarInfoView;
@end

@implementation KPHotLiveCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self configElements];
    }
    return self;
}

- (void)configElements {
    
    [self configAvatarInfoView];
    [self configCoverImv];
    [self configLiveImv];
}

- (void)configAvatarInfoView {
    
    if (!_avatarInfoView) {
        _avatarInfoView = ({
            KPHotAvatorView *view = [[KPHotAvatorView alloc] init];
            [self.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.offset(10);
                make.height.offset(50);
                make.left.right.equalTo(self.contentView);
            }];
            view;
        });
    }
}

- (void)configCoverImv {

    if (!_coverImv) {
        _coverImv = ({
        
            UIImageView *imageView = [[UIImageView alloc] init];
            [self.contentView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(_avatarInfoView.mas_bottom).offset(10);
                make.left.right.bottom.equalTo(self.contentView);
            }];
            imageView;
        });
    }
}

- (void)configLiveImv {

    if (!_liveImv) {
        _liveImv = ({
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_tag_live"]];
            [_coverImv addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.offset(20);
                make.right.offset(-20);
            }];
            imageView;
        });
    }
}

- (void)setHotLiveModel:(KPHotLiveModel *)hotLiveModel {
    
    _avatarInfoView.hotLiveModel = hotLiveModel;
    if ([hotLiveModel.creator.portrait isEqualToString:@"kunpeng.JPG"]) {
        _coverImv.image = [UIImage imageNamed:@"kunpeng.JPG"];
        return;
    }
    [_coverImv downloadImage:hotLiveModel.creator.portrait
                  placeholder:@"default_room"];
}

@end
