//
//  PSPalyerManger.h
//  ELNSchool
//
//  Created by rainsoft on 2019/6/14.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kRemotePlayerURLOrStateChangeNotification @"remotePlayerURLOrStateChangeNotification"

typedef NS_ENUM(NSInteger,PSPlayerState) {
    PSPlayerStateUnknow,  //未知(比如都没有开始播放音乐)
    PSPlayerStateLoading, //正在加载
    PSPlayerStatePlaying, //正在播放
    PSPlayerStatePause, //暂停播放
    PSPlayerStateStop, //停止播放
    PSPlayerStateFailed //失败(比如没有网络缓存失败, 地址找不到)
};

@interface LHZPlayerManger : NSObject

+(instancetype)manger;

- (void)playWithUrlstr:(NSString *)urlStr isCache:(BOOL)isCache;

/** 暂停当前音频 */
- (void)pause;

/** 继续播放 */
- (void)resume;

/** 停止播放 */
- (void)stop;

/**
 快速播放到某个时间点
 @param time 时间
 */
- (void)seekWithTime: (NSTimeInterval)time;

/** 速率 */
@property (nonatomic, assign) float rate;

/** 声音 */
@property (nonatomic, assign) float volume;

/** 静音 */
@property (nonatomic, assign) BOOL mute;

/** 根据进度播放 */
@property (nonatomic, assign) float progress;

/** 音频总时长 */
@property (nonatomic, assign) double duration;

/** 音频当前播放时长 */
@property (nonatomic, assign) double currentTime;

/** 音频当前加载进度 */
@property (nonatomic, assign) float loadProgress;

/** 音频当前播放状态 */
@property (nonatomic, assign) PSPlayerState state;

/** 监听音频播放状态 */
@property (nonatomic, copy) void(^stateChange)(PSPlayerState state);

/** 监听音频播放完成 */
@property (nonatomic, copy) void(^playEndBlock)(void);

@end

NS_ASSUME_NONNULL_END
