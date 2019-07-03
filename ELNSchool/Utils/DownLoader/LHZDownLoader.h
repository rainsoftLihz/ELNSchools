//
//  PSDownLoader.h
//  ELNSchool
//
//  Created by rainsoft on 2019/6/14.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LHZDownLoaderFileTool.h"

#import "NSString+LHZDownLoader.h"

NS_ASSUME_NONNULL_BEGIN



#define kDownLoadURLOrStateChangeNotification @"downLoadURLOrStateChangeNotification"

typedef enum : NSUInteger {
    PSDownLoaderStateUnKnown,
    /** 下载暂停 */
    LHZDownLoaderStatePause,
    /** 正在下载 */
    LHZDownLoaderStateDowning,
    /** 已经下载 */
    LHZDownLoaderStateSuccess,
    /** 下载失败 */
    LHZDownLoaderStateFailed
} LHZDownLoaderState;

//下载文件总大小 等文件信息
typedef void(^LHZDownLoadFileInfo)(long long fileSize);
//下载成功后本地路径
typedef void(^LHZDownLoadSuccess)(NSString *cacheFilePath);
//下载失败
typedef void(^LHZDownLoadFail)(void);

@interface LHZDownLoader : NSObject

//下载
- (void)downLoadWithURL: (NSURL *)url downLoadInfo: (LHZDownLoadFileInfo)downLoadFileInfo success: (LHZDownLoadSuccess)successBlock failed:(LHZDownLoadFail)failBlock;

- (void)downLoadWithURL: (NSURL *)url;

// 恢复下载
- (void)resume;

// 暂停, 暂停任务, 可以恢复, 缓存没有删除
- (void)pause;

// 取消
- (void)cancel;

// 缓存删除
- (void)cancelAndClearCache;

// 状态
@property (nonatomic, assign) LHZDownLoaderState state;

// 进度
@property (nonatomic, assign) float progress;

// 下载进度
@property (nonatomic, copy) void(^downLoadProgress)(float progress);

// 文件下载信息 (下载的大小)
@property (nonatomic, copy) LHZDownLoadFileInfo downLoadInfo;

// 状态的改变 ()
@property (nonatomic, copy) void(^downLoadStateChange)(LHZDownLoaderState state);

// 下载成功 (成功路径)
@property (nonatomic, copy) LHZDownLoadSuccess downLoadSuccess;

// 失败 (错误信息)
@property (nonatomic, copy) LHZDownLoadFail downLoadError;

@end

NS_ASSUME_NONNULL_END
