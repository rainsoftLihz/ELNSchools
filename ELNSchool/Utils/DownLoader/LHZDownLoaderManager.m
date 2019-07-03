//
//  PSDownLoaderManager.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/14.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "LHZDownLoaderManager.h"

@interface LHZDownLoaderManager()
//批量下载资源
@property (nonatomic, strong) NSMutableDictionary <NSString *, LHZDownLoader *>*downLoadDic;
//排序
@property (nonatomic, strong) NSMutableArray *downLoadArr;

@end

@implementation LHZDownLoaderManager

//同时下载的最大任务数
static NSInteger maxLoader = 5;

static LHZDownLoaderManager *_manager;
+ (instancetype)manger {
    if (!_manager) {
        _manager = [[LHZDownLoaderManager alloc] init];
    }
    return _manager;
}

-(NSMutableDictionary<NSString *,LHZDownLoader *> *)downLoadDic{
    if (_downLoadDic == nil) {
        _downLoadDic = [NSMutableDictionary dictionary];
    }
    return _downLoadDic;
}

-(NSMutableArray *)downLoadArr{
    if (_downLoadArr == nil) {
        _downLoadArr = [NSMutableArray array];
    }
    return _downLoadArr;
}

-(void)addToDownLoad:(LHZDownLoader*)downLoad forKey:(NSString*)md5{
    [self.downLoadDic setValue:downLoad forKey:md5];
    [self.downLoadArr addObject:md5];
}

-(void)removeDownLoadForKey:(NSString*)md5{
    //删除任务
    [self.downLoadDic removeObjectForKey:md5];
    //从数组删除
    [self.downLoadArr removeObject:md5];
}


#pragma mark --- 下载
- (void)downLoadWithURL: (NSURL *)url downLoadInfo: (LHZDownLoadFileInfo)downLoadFileInfo success: (LHZDownLoadSuccess)successBlock failed:(LHZDownLoadFail)failBlock {
    
    // 文件名称  aaa/a.x  bb/a.x
    NSString *md5 = [url.absoluteString md5Str];
    LHZDownLoader *downLoader = self.downLoadDic[md5];
    if (downLoader) {
        //下载
        [downLoader resume];
        return;
    }
    
    //初始化downLoader
    downLoader = [[LHZDownLoader alloc] init];
    //添加数据源
    [self addToDownLoad:downLoader forKey:md5];
    
    __weak typeof(self)wkSelf = self;
    [downLoader downLoadWithURL:url downLoadInfo:^(long long fileSize) {
        if (downLoadFileInfo) {
            downLoadFileInfo(fileSize);
        }
    } success:^(NSString * _Nonnull cacheFilePath) {
        if (successBlock) {
            successBlock(cacheFilePath);
        }
    } failed:^{
        //删除任务
        [wkSelf removeDownLoadForKey:md5];
        
        if (failBlock) {
            failBlock();
        }
    }];
    
    return;
    
}

//直接下载
-(LHZDownLoader*)downLoadURL:(NSURL*)url{
    // 文件名称  aaa/a.x  bb/a.x
    NSString *md5 = [url.absoluteString md5Str];
    LHZDownLoader *downLoader = self.downLoadDic[md5];
    if (downLoader) {
        //下载
        [downLoader resume];
        return downLoader;
    }
    
    downLoader = [[LHZDownLoader alloc] init];
    [self addToDownLoad:downLoader forKey:md5];
    
    __weak typeof(self)wkSelf = self;
    [downLoader downLoadWithURL:url downLoadInfo:^(long long fileSize) {
        //文件大小
    } success:^(NSString * _Nonnull cacheFilePath) {
        //下载成功删除该链接md5
        [wkSelf removeDownLoadForKey:md5];
    } failed:^{
        [wkSelf removeDownLoadForKey:md5];
    }];
    
    return downLoader;
}

- (LHZDownLoader *)getDownLoaderWithURL: (NSURL *)url {
    NSString *md5 = [url.absoluteString md5Str];
    LHZDownLoader *downLoader = self.downLoadDic[md5];
    return downLoader;
}

//暂停任务
- (void)pauseWithURL: (NSURL *)url {
    NSString *md5 = [url.absoluteString md5Str];
    LHZDownLoader *downLoader = self.downLoadDic[md5];
    [downLoader pause];
}

//继续下载
- (void)resumWithURL: (NSURL *)url {
    NSString *md5 = [url.absoluteString md5Str];
    LHZDownLoader *downLoader = self.downLoadDic[md5];
    [downLoader resume];
}

//取消任务  or 删除任务
- (void)cancelWithURL: (NSURL *)url {
    NSString *md5 = [url.absoluteString md5Str];
    LHZDownLoader *downLoader = self.downLoadDic[md5];
    [downLoader cancel];
    
    [self removeDownLoadForKey:md5];
}


- (void)cancelAndClearWithURL: (NSURL *)url {
    NSString *md5 = [url.absoluteString md5Str];
    LHZDownLoader *downLoader = self.downLoadDic[md5];
    [downLoader cancelAndClearCache];
    
    [self removeDownLoadForKey:md5];
}


//暂停所有下载任务
- (void)pauseAll {
    [[self.downLoadDic allValues] makeObjectsPerformSelector:@selector(pause)];
}

- (void)resumeAll {
    [[self.downLoadDic allValues] makeObjectsPerformSelector:@selector(resume)];
}

@end
