//
//  PSPlayerResourceLoder.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/14.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "LHZPlayerResourceLoder.h"
#import "LHZDownLoader.h"
#import "LHZDownLoaderFileTool.h"
@interface LHZPlayerResourceLoder()



@end

@implementation LHZPlayerResourceLoder

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest
{
    NSLog(@"发送某个请求--%@", loadingRequest.request.URL);
    
    // 下载的url地址
    NSURL *url = loadingRequest.request.URL;
    
    long long requestOffSet = loadingRequest.dataRequest.requestedOffset;
    if (loadingRequest.dataRequest.currentOffset != 0) {
        requestOffSet = loadingRequest.dataRequest.currentOffset;
    }
    
    //下载成功
    if ([LHZDownLoaderFileTool isCacheFileExists:url])
    {
        // 三个步骤, 直接响应数据
        [self handleRequestWithLoadingRequest:loadingRequest];
        
        return YES;
    }
    
    // 请求的数据, 就在正在下载当中
    // 在正在下载数据当中, data -> 播放器
    
    return YES;
}


// 取消某个请求的时候调用
- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest
{
    NSLog(@"取消请求");
}

#pragma mark - 私有方法

- (void)handleRequestWithLoadingRequest: (AVAssetResourceLoadingRequest *)loadingRequest {
    
    NSURLComponents *commpents = [NSURLComponents componentsWithString:loadingRequest.request.URL.absoluteString];
    [commpents setScheme:@"http"];
    NSURL *url = [commpents URL];
    // 1. 填充信息头
    loadingRequest.contentInformationRequest.contentType = [LHZDownLoaderFileTool contentTypeWithURL:url];
    loadingRequest.contentInformationRequest.contentLength = [LHZDownLoaderFileTool cacheFileSizeWithURL:url];
    loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
    
    
    // 2. 响应数据
    NSData *data = [NSData dataWithContentsOfFile:[LHZDownLoaderFileTool cachePathWithURL:url] options:NSDataReadingMappedIfSafe error:nil];
    
    long long requestOffset = loadingRequest.dataRequest.requestedOffset;
    long long requestLen = loadingRequest.dataRequest.requestedLength;
    
    NSData *subData = [data subdataWithRange:NSMakeRange(requestOffset, requestLen)];
    
    [loadingRequest.dataRequest respondWithData:subData];
    
    // 3. 完成这个请求
    [loadingRequest finishLoading];
}

@end
