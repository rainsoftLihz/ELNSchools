//
//  PSDownLoader.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/14.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "LHZDownLoader.h"

@interface LHZDownLoader()<NSURLSessionDataDelegate>
{
    // 临时文件的大小
    long long _tmpFileSize;
    // 文件的总大小
    long long _totalFileSize;
    
}
/** 文件的缓存路径 */
@property (nonatomic, copy) NSString *cacheFilePath;
/** 文件的临时缓存路径 */
@property (nonatomic, copy) NSString *tmpFilePath;
/** 下载会话 */
@property (nonatomic, strong) NSURLSession *session;
/** 文件输出流 */
@property (nonatomic, strong) NSOutputStream *outputStream;
/** 下载任务 */
@property (nonatomic, weak) NSURLSessionDataTask *task;

@property (nonatomic, weak) NSURL *url;
@end

@implementation LHZDownLoader

#pragma mark --- 下载
- (void)downLoadWithURL: (NSURL *)url downLoadInfo: (LHZDownLoadFileInfo)downLoadFileInfo success: (LHZDownLoadSuccess)successBlock failed:(LHZDownLoadFail)failBlock {
    
    self.downLoadInfo = downLoadFileInfo;
    self.downLoadSuccess = successBlock;
    self.downLoadError = failBlock;
    
    [self downLoadWithURL:url];
}

- (void)downLoadWithURL: (NSURL *)url {
    
    self.url = url;
    // 1. 下载文件的存储
    //    下载中 -> tmp + (url + MD5)
    //    下载完成 -> cache + url.lastCompent
    self.cacheFilePath = [kCachePath stringByAppendingPathComponent:url.lastPathComponent];
    self.tmpFilePath = [kTmpPath stringByAppendingPathComponent:[url.absoluteString md5Str]];
    
    
    // 1 首先, 判断, 本地有没有已经下载好, 已经下载完毕, 就直接返回
    // 文件的位置, 文件的大小
    if ([LHZDownLoaderFileTool isFileExists:self.cacheFilePath]) {
        NSLog(@"文件已经下载完毕, 直接返回相应的数据--文件的具体路径, 文件的大小");
        
        if (self.downLoadInfo) {
            self.downLoadInfo([LHZDownLoaderFileTool fileSizeWithPath:self.cacheFilePath]);
        }
        
        self.state = LHZDownLoaderStateSuccess;
        
        if (self.downLoadSuccess) {
            self.downLoadSuccess(self.cacheFilePath);
        }
        
        return;
    }
    
    // 验证: 如果当前任务不存在 -> 开启任务
    if ([url isEqual:self.task.originalRequest.URL]) {
        // 任务存在 -> 状态
        // 状态 -> 正在下载 返回
        if (self.state == LHZDownLoaderStateDowning)
        {
            return;
        }
        // 状态 -> 暂停 = 恢复
        if (self.state == LHZDownLoaderStatePause)
        {
            [self resume];
            return;
        }
        
        // 取消, 重新下载 == 失败
    }
    
    // 任务不存在, url不一样
    [self cancel];
    // 2. 读取本地的缓存大小
    _tmpFileSize = [LHZDownLoaderFileTool fileSizeWithPath:self.tmpFilePath];
    [self downLoadWithURL:url offset:_tmpFileSize];
}

// 暂停了几次, 恢复几次, 才可以恢复
- (void)resume {
    if (self.state == LHZDownLoaderStatePause) {
        [self.task resume];
        self.state = LHZDownLoaderStateDowning;
    }
}

// 暂停, 暂停任务, 可以恢复, 缓存没有删除
// 恢复了几次, 暂停几次, 才可以暂停
- (void)pause {
    if (self.state == LHZDownLoaderStateDowning)
    {
        [self.task suspend];
        self.state = LHZDownLoaderStatePause;
    }
    
}

// 取消, 这次任务已经被取消, 缓存删除
- (void)cancel {
    [self.session invalidateAndCancel];
    self.session = nil;
}

//取消
- (void)cancelAndClearCache {
    [self cancel];
    [LHZDownLoaderFileTool removeFileAtPath:self.tmpFilePath];
}

#pragma mark - 私有方法
- (void)downLoadWithURL:(NSURL *)url offset: (long long)offset {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-", offset] forHTTPHeaderField:@"Range"];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    [task resume];
    self.task = task;
}


#pragma mark - NSURLSessionDataDelegate
/**
 当发送的请求, 第一次接受到响应的时候调用,
 @param completionHandler 系统传递给我们的一个回调代码块, 我们可以通过这个代码块, 来告诉系统,如何处理, 接下来的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    _totalFileSize = [httpResponse.allHeaderFields[@"Content-Length"] longLongValue];
    if (httpResponse.allHeaderFields[@"Content-Range"]) {
        NSString *rangeStr = httpResponse.allHeaderFields[@"Content-Range"] ;
        _totalFileSize = [[[rangeStr componentsSeparatedByString:@"/"] lastObject] longLongValue];
    }
    if (self.downLoadInfo) {
        self.downLoadInfo(_totalFileSize);
    }
    // 判断, 本地的缓存大小 与 文件的总大小
    // 缓存大小 == 文件的总大小 下载完成 -> 移动到下载完成的文件夹
    if (_tmpFileSize == _totalFileSize) {
        NSLog(@"文件已经下载完成, 移动数据");
        // 移动临时缓存的文件 -> 下载完成的路径
        [LHZDownLoaderFileTool moveFile:self.tmpFilePath toPath:self.cacheFilePath];
        self.state = LHZDownLoaderStateSuccess;
        // 取消请求
        completionHandler(NSURLSessionResponseCancel);
        return;
    }
    
    if (_tmpFileSize > _totalFileSize) {
        
        NSLog(@"缓存有问题, 删除缓存, 重新下载");
        // 删除缓存
        [LHZDownLoaderFileTool removeFileAtPath:self.tmpFilePath];
        
        // 取消请求
        completionHandler(NSURLSessionResponseCancel);
        
        // 重新发送请求  0
        [self downLoadWithURL:response.URL offset:0];
        return;
    }
    
    // 继续接收数据,什么都不要处理
    NSLog(@"继续接收数据");
    self.state = LHZDownLoaderStateDowning;
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:self.tmpFilePath append:YES];
    [self.outputStream open];
    
    completionHandler(NSURLSessionResponseAllow);
}

// 接收数据的时候调用
// 100M
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 进度 = 当前下载的大小 / 总大小
    _tmpFileSize += data.length;
    self.progress = 1.0 * _tmpFileSize / _totalFileSize;
    [self.outputStream write:data.bytes maxLength:data.length];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    [self.outputStream close];
    self.outputStream = nil;
    if (error == nil) {
        NSLog(@"下载完毕, 成功");
        // 移动数据  temp - > cache
        [LHZDownLoaderFileTool moveFile:self.tmpFilePath toPath:self.cacheFilePath];
        self.state = LHZDownLoaderStateSuccess;
        if (self.downLoadSuccess) {
            self.downLoadSuccess(self.cacheFilePath);
        }
    }else {
        NSLog(@"有错误---");
        //        error.code
        //        error.localizedDescription;
        self.state = LHZDownLoaderStateFailed;
        if (self.downLoadError) {
            self.downLoadError();
        }
    }
}

#pragma mark - 懒加载
- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (void)setState:(LHZDownLoaderState)state {
    if (_state == state) {
        return;
    }
    _state = state;
    if (self.downLoadStateChange) {
        self.downLoadStateChange(state);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kDownLoadURLOrStateChangeNotification object:nil userInfo:@{                                                                                                                           @"downLoadURL": self.url,                                                                                                                           @"downLoadState": @(self.state)                                                                                                                           }];
}

- (void)setProgress:(float)progress {
    _progress = progress;
    if (self.downLoadProgress) {
        self.downLoadProgress(progress);
    }
}

//size
+ (long long)tmpCacheSizeWithURL: (NSURL *)url {
    
    NSString *tmpFileMD5 = [url.absoluteString md5Str];
    NSString *tmpPath = [kTmpPath stringByAppendingPathComponent:tmpFileMD5];
    return  [LHZDownLoaderFileTool fileSizeWithPath:tmpPath];
}

//clear
+ (void)clearCacheWithURL: (NSURL *)url {
    NSString *cachePath = [kCachePath stringByAppendingPathComponent:url.lastPathComponent];
    [LHZDownLoaderFileTool removeFileAtPath:cachePath];
}

@end
