//
//  KPLaunchController.m
//  KPLive
//
//  Created by kunpeng on 2017/3/21.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPLaunchController.h"
#import "LFLivePreview.h"

@interface KPLaunchController ()

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@end

@implementation KPLaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self configBackImageView];
}

- (void)configBackImageView {
    
    _backImageView.image = [UIImage imageNamed:@"bg_zbfx"];
}

- (IBAction)startLive:(UIButton *)sender {
    
    UIView * back = [[UIView alloc] initWithFrame:self.view.bounds];
    back.backgroundColor = [UIColor blackColor];
    [self.view addSubview:back];
    
    LFLivePreview *liveView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:liveView];
    [liveView startLive];
}

- (IBAction)closeButtonEvent:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
