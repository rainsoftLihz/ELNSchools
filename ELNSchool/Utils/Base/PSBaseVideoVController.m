//
//  PSBaseVideoVController.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/12.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseVideoVController.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import "UIImageView+ZFCache.h"
#import "ZFUtilities.h"

#import "ZFUtilities.h"

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

@interface PSBaseVideoVController ()
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) NSURL* assetURL;
//default No
@property (nonatomic, assign) BOOL autoPlay;

@end

@implementation PSBaseVideoVController

#pragma mark --- init
-(instancetype)initWith:(BOOL)autoPlay and:(NSString*)url{
    if (self = [super init]) {
        [self _init];
        self.autoPlay = autoPlay;
        self.assetURL = [NSURL URLWithString:url];
    }
    return self;
}

-(instancetype)initWith:(NSString*)url{
    if (self = [super init]) {
        [self _init];
        self.assetURL = [NSURL URLWithString:url];
        self.autoPlay = NO;
    }
    return self;
}

-(void)_init{
    /// 播放器相关
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.containerView];
    
    if (!self.autoPlay) {
       [self.containerView addSubview:self.playBtn];
    }
    
    if (self.autoPlay) {
        //自动加载播放
        self.player.assetURL = self.assetURL;
    }
    
    /// 播放完成
    @weakify(self);
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self);
        [self.player.currentPlayerManager stop];
    };
}


#pragma mark --- 屏幕旋转全屏
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark --- UI布局
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame)-w)/2;
    y = (CGRectGetHeight(self.containerView.frame)-h)/2;
    self.playBtn.frame = CGRectMake(x, y, w, h);
}

#pragma mark --- lazy
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView sd_setImageWithURL:[NSURL URLWithString:kVideoCover]];
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (void)playClick:(UIButton *)sender {
    self.player.assetURL = self.assetURL;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
