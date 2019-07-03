//
//  PSDownLoaderManager.h
//  ELNSchool
//
//  Created by rainsoft on 2019/6/14.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHZDownLoader.h"
NS_ASSUME_NONNULL_BEGIN

@interface LHZDownLoaderManager : NSObject

+ (instancetype)manger;

// 根据URL下载资源
-(LHZDownLoader*)downLoadURL:(NSURL*)url;

// 根据URL下载资源
// 监听下载信息, 成功, 失败回调
- (void)downLoadWithURL: (NSURL *)url downLoadInfo: (LHZDownLoadFileInfo)downLoadFileInfo success: (LHZDownLoadSuccess)successBlock failed:(LHZDownLoadFail)failBlock;

// 根据URL暂停资源
- (void)pauseWithURL: (NSURL *)url;

// 根据URL取消资源
- (void)cancelWithURL: (NSURL *)url;
- (void)cancelAndClearWithURL: (NSURL *)url;

// 暂停所有
- (void)pauseAll;

// 恢复所有
- (void)resumeAll;

//继续下载
- (void)resumWithURL: (NSURL *)url;

@end

NS_ASSUME_NONNULL_END
