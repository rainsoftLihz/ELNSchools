//
//  PSPalyerManger.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/14.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "LHZPlayerManger.h"
#import <AVFoundation/AVFoundation.h>
#import "LHZPlayerResourceLoder.h"
#import "LHZDownLoaderFileTool.h"
#import "LHZDownLoaderManager.h"
@interface LHZPlayerManger()
//播放器
@property (nonatomic, strong) AVPlayer *player;
//资源下载
@property (nonatomic, strong) LHZPlayerResourceLoder* resourceLoder;
/** 音频当前播放URL */
@property (nonatomic, strong) NSURL *url;

@end

@implementation LHZPlayerManger

static LHZPlayerManger* _manger;
+(instancetype)manger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manger = [[LHZPlayerManger alloc] init];
    });
    return _manger;
}

#pragma mark  --- play
- (void)playWithUrlstr: (NSString *)urlStr isCache:(BOOL)isCache {
    
    [self playWithURL:[NSURL URLWithString:urlStr] isCache:isCache];
}

- (void)playWithURL: (NSURL *)url isCache:(BOOL)isCache {

    //与当前资源同一个链接
    if ([self.url isEqual:url]) {
        
        if (self.state == PSPlayerStatePlaying ||
            self.state ==  PSPlayerStateLoading) {
            //正在播放 或者在加载资源
            return;
        }
        
        if (self.state == PSPlayerStatePause) {
            //暂停 ---> 恢复播放
            [self resume];
            return;
        }
    }
    
    //播放初始化流程
    self.url = url;
    if (self.player.currentItem) {
        [self clearObserver:self.player.currentItem];
    }
    
    NSURL *lastURL = url;
    if (isCache) {
        if (![LHZDownLoaderFileTool isCacheFileExists:self.url]) {
            //下载文件
            [[LHZDownLoaderManager manger]downLoadURL:url];
        }
    }
    
    if ([LHZDownLoaderFileTool isCacheFileExists:self.url]) {
        //文件已下载  使用本地资源
        lastURL = [NSURL URLWithString:[LHZDownLoaderFileTool cachePathWithURL:self.url] ];
    }
    NSLog(@"path===>>>%@",lastURL);
    //1. 资源的请求
    AVURLAsset *asset = [AVURLAsset assetWithURL:lastURL];
    self.resourceLoder = [[LHZPlayerResourceLoder alloc] init];
    [asset.resourceLoader setDelegate:self.resourceLoder queue:dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    // 2. 资源的组织
    AVPlayerItem* item = [[AVPlayerItem alloc] initWithAsset:asset];
    // 监听资源的组织者, 有没有组织好数据
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playIntrupt) name:AVPlayerItemPlaybackStalledNotification object:nil];
    
    // 3. 资源的播放
    [self.player pause];
    self.player = [AVPlayer playerWithPlayerItem:item];
}

#pragma mark --- 暂停 播放 停止
- (void)pause{
    [self.player pause];
    if (self.player) {
        self.state = PSPlayerStatePause;
    }
}

-(void)resume{
    [self.player play];
    if (self.player && self.player.currentItem.playbackLikelyToKeepUp) {
        //更改状态
        self.state = PSPlayerStatePlaying;
    }
}

-(void)stop{
    [self.player pause];
    [self clearObserver:self.player.currentItem];
    self.player = nil;
    if (self.player) {
        self.state = PSPlayerStateStop;
    }
}


#pragma mark  ----  kVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:
            {
                NSLog(@"准备完毕, 开始播放");
                [self resume];
                break;
            }
            case AVPlayerItemStatusFailed:
            {
                NSLog(@"数据准备失败, 无法播放");
                self.state = PSPlayerStateFailed;
                break;
            }
                
            default:
            {
                NSLog(@"未知");
                self.state = PSPlayerStateUnknow;
                break;
            }
        }
        
    }
    
    if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        // 代表, 是否加载的可以进行播放了
        BOOL playbackLikelyToKeepUp = [change[NSKeyValueChangeNewKey] boolValue];
        if (playbackLikelyToKeepUp) {
            NSLog(@"数据加载的足够播放了");
            
            // 能调用, 播放
            // 手动暂停, 优先级 > 自动播放
            [self resume];
            
        }else {
            NSLog(@"数据不够播放");
            self.state = PSPlayerStateLoading;
        }
    }
    
}

//播放结束
- (void)playEnd {
    self.state = PSPlayerStateStop;
    if (self.playEndBlock) {
        self.playEndBlock();
    }
    
}
//播放中止
- (void)playIntrupt {
    NSLog(@"播放被打断");
    self.state = PSPlayerStatePause;
}




#pragma mark --- propoty  set get
//状态值改变
- (void)setState:(PSPlayerState)state {
    _state = state;
    if (self.stateChange) {
        self.stateChange(state);
    }
    if (self.url) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kRemotePlayerURLOrStateChangeNotification object:nil userInfo:@{                                                                                                                                   @"playURL": self.url,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            @"playState": @(state)                                                                                                                                   }];
    }
}

-(void)setRate:(float)rate{
    self.player.rate = rate;
}

- (float)rate{
    return self.player.rate;
}

- (void)setVolume:(float)volume {
    if (volume > 0) {
        [self setMute:NO];
    }
    self.player.volume = volume;
}
- (float)volume {
    return self.player.volume;
}

- (void)setMute:(BOOL)mute {
    self.player.muted = mute;
}

- (BOOL)mute {
    return self.player.isMuted;
}

- (void)seekWithTime: (NSTimeInterval)time{
    // 1. 获取当前的时间点(秒)
    double currentTime = self.currentTime + time;
    double totalTime = self.duration;
    
    [self setProgress:currentTime / totalTime];
    
}

- (double)duration {
    double time = CMTimeGetSeconds(self.player.currentItem.duration);
    if (isnan(time)) {
        return 0;
    }
    return time;
}

- (double)currentTime {
    
    double time = CMTimeGetSeconds(self.player.currentItem.currentTime);
    
    if (isnan(time)) {
        return 0;
    }
    return time;
}

- (float)progress {
    
    if (self.duration == 0) {
        return 0;
    }
    return self.currentTime / self.duration;
    
}

- (void)setProgress:(float)progress {
    
    // 0.0 - 1.0
    // 1. 计算总时间 (秒) * progress
    
    double totalTime = self.duration;
    double currentTimeSec = totalTime * progress;
    CMTime playTime = CMTimeMakeWithSeconds(currentTimeSec, NSEC_PER_SEC);
    
    [self.player seekToTime:playTime completionHandler:^(BOOL finished) {
        
        if (finished) {
            NSLog(@"确认加载这个时间节点的数据");
        }else {
            NSLog(@"取消加载这个时间节点的播放数据");
        }
    }];
}


#pragma mark ---  dealloc
- (void)clearObserver: (AVPlayerItem *)item {
    [item removeObserver:self forKeyPath:@"status"];
    [item removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
}



- (void)dealloc {
    [self clearObserver:self.player.currentItem];
}

@end
