//
//  KPAdvertise.m
//  KPLive
//
//  Created by kunpeng on 2017/3/21.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPAdvertiseView.h"
#import "KPShowHandler.h"
#import "KPAdvertise.h"
#import "KPCacheHelper.h"

@interface KPAdvertiseView ()

@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIImageView *advertiseImageView;
@end

static NSInteger showTime = 3;
@implementation KPAdvertiseView

+ (instancetype)loadAdvertiseView {

    return [[[NSBundle mainBundle] loadNibNamed:@"KPAdvertiseView"
                                         owner:self
                                        options:nil] lastObject];;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.frame = [UIScreen mainScreen].bounds;
    [self showAdvertise];
    [self downloadAdvertise];
    [self startCountdown];
}

- (void)showAdvertise {
    
    NSString *filePath = [KPCacheHelper getAdvertise];
    UIImage *lastCacheImage = [[SDWebImageManager sharedManager].imageCache
                               imageFromDiskCacheForKey:filePath];
    if (lastCacheImage) {
        
        _advertiseImageView.image = lastCacheImage;
    }else {
        
        self.hidden = YES;
    }
}

- (void)downloadAdvertise {
    
    [KPShowHandler executeGetAdTaskWithSuccess:^(id obj) {
    
        KPAdvertise *advetise = obj;
        NSURL *imageUrl = [NSURL URLWithString:advetise.image];
        [[SDWebImageManager sharedManager] loadImageWithURL:imageUrl
                                                    options:SDWebImageAvoidAutoSetImage
                                                   progress:nil
                                                  completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            
            [KPCacheHelper setAdvertise:advetise.image];
        }];
    } failure:^(id obj) {
        
        NSLog(@"%@",obj);
    }];
}

- (void)startCountdown {
    
    __block NSInteger timeout = showTime + 1; //倒计时加1保证秒数显示完整
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeout <= 0) {
            
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                 [self dismiss];
            });
        }else {
        
            timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                
               _countdownLabel.text = [NSString stringWithFormat:@"跳过 (%zd) ",timeout];
            });
        }
    });
    
    dispatch_resume(timer);
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

@end
