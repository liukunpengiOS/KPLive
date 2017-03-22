//
//  KPShowChatController.m
//  KPLive
//
//  Created by kunpeng on 2017/3/20.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPShowChatController.h"

@interface KPShowChatController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *onUserCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (nonatomic,strong) dispatch_source_t timer;
@end

@implementation KPShowChatController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configElements];
}

#pragma mark - Config Elements
- (void)configElements {

    [self configIconImageView];
    [self configOnUserCountLabel];
    [self configTimer];
}

- (void)configIconImageView {

    _iconImageView.layer.cornerRadius = 15;
    _iconImageView.layer.masksToBounds = YES;
}

- (void)configOnUserCountLabel {
 
    @weakify(self);
    [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        @strongify(self);
        
        self.onUserCountLabel.text = [NSString stringWithFormat:@"%d",arc4random_uniform(10000)];

    } repeats:YES];
}

- (void)configTimer {
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        [self configLoveAnimationFromView:_shareButton toView:self.view];
    });
    dispatch_resume(_timer);
}

- (void)configLoveAnimationFromView:(UIView *)fromView toView:(UIView *)toView {
    
    //准备动画使用的图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    CGRect loveFrame = [fromView convertRect:fromView.frame toView:toView];
    CGPoint position = CGPointMake(fromView.layer.position.x, loveFrame.origin.y - 30);
    imageView.layer.position = position;
    NSArray *imageArray = @[@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5",@"heart_1"];
    NSInteger imageIndex = arc4random() % 6;
    imageView.image = [UIImage imageNamed:imageArray[imageIndex]];
    [toView addSubview:imageView];
    
    imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            imageView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    CGFloat duration = 3 + arc4random() % 5;
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.repeatCount = 1;
    positionAnimation.duration = duration;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = NO;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:position];
    CGFloat sign = arc4random() % 2 == 1 ? 1 : -1;
    CGFloat controlPointValue = (arc4random() % 50 + arc4random() % 100) * sign;
    [bezierPath addCurveToPoint:CGPointMake(position.x, position.y - 300)
             controlPoint1:CGPointMake(position.x - controlPointValue, position.y - 150)
             controlPoint2:CGPointMake(position.x + controlPointValue, position.y - 150)];
    positionAnimation.path = bezierPath.CGPath;
    [imageView.layer addAnimation:positionAnimation forKey:@"heartAnimated"];
    
    [UIView animateWithDuration:duration animations:^{
        imageView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

#pragma mark - Event response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self configLoveAnimationFromView:_shareButton toView:self.view];
}

#pragma mark - setter and getter
- (void)setHotLiveModel:(KPHotLiveModel *)hotLiveModel {
    
    _hotLiveModel = hotLiveModel;
    [_iconImageView downloadImage:_hotLiveModel.creator.portrait placeholder:@"default_room"];
}

@end
