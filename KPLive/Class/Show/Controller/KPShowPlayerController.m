//
//  KPPlayerController.m
//  KPLive
//
//  Created by kunpeng on 2017/3/17.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPShowPlayerController.h"
#import "KPShowChatController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "AppDelegate.h"

@interface KPShowPlayerController ()

@property (nonatomic,strong) id<IJKMediaPlayback> player;
@property (nonatomic,strong) UIImageView *blurImv;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,strong) KPShowChatController *showChatController;
@end

@implementation KPShowPlayerController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.player prepareToPlay];
    [self installMovieNotificationObservers];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.player shutdown];
    [_closeButton removeFromSuperview];
    [self removeMovieNotificationObservers];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self configElements];
}

- (void)configElements {
    
    [self configPlayer];
    [self configBlurEffect];
    [self configCloseButton];
    [self configShowChatController];
}

- (void)configPlayer {

    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_hotLiveModel.streamAddr
                                                                                          withOptions:options];
    self.player = player;
    self.player.view.frame = self.view.bounds;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
   // [self.view addSubview:self.mediaControl];
}

- (void)configBlurEffect {
    
    self.view.backgroundColor = [UIColor blackColor];
    _blurImv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _blurImv.contentMode = UIViewContentModeScaleAspectFill;
    _blurImv.clipsToBounds = YES;
    [_blurImv downloadImage:_hotLiveModel.creator.portrait placeholder:@"default_room"];
    [self.view addSubview:_blurImv];
    
    UIBlurEffect *blurEffect = [UIBlurEffect  effectWithStyle:UIBlurEffectStyleLight];//效果
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];//视图
    visualEffectView.frame = _blurImv.bounds;
    [_blurImv addSubview:visualEffectView];
}

- (UIButton *)configCloseButton {
    
    if (!_closeButton) {
            
        _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *closeImage = [UIImage imageNamed:@"mg_room_btn_guan_h"];
        closeImage = [closeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_closeButton setImage:closeImage forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButton:)
         forControlEvents:UIControlEventTouchUpInside];
        
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [window addSubview:_closeButton];
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.offset(-10);
        }];
    }
    return _closeButton;
}

- (KPShowChatController *)configShowChatController {

    if (!_showChatController) {
        _showChatController = [[KPShowChatController alloc] init];
        [self addChildViewController:_showChatController];
        [self.view addSubview:_showChatController.view];
        [_showChatController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _showChatController.hotLiveModel = _hotLiveModel;
    }
    return _showChatController;
}

#pragma mark - private methods
/* Register observers for the various movie object notifications. */
- (void)installMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

/* Remove the movie notification observers from the movie object. */
- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}

- (void)loadStateDidChange:(NSNotification*)notification {
    
    //    MPMovieLoadStateUnknown        = 0,
    //    MPMovieLoadStatePlayable       = 1 << 0,
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        
        [_blurImv removeFromSuperview];
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

#pragma mark - Event response

- (void)closeButton:(UIButton *)closeButton {

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - movieplayer delegate

- (void)moviePlayBackDidFinish:(NSNotification*)notification {
    
    //    MPMovieFinishReasonPlaybackEnded,
    //    MPMovieFinishReasonPlaybackError,
    //    MPMovieFinishReasonUserExited
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason) {
            
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

@end
