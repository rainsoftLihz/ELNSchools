//
//  PSBaseAPI.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSCGIManager.h"
#import "PSRsponse.h"
#import "PSCGIServer.h"
NS_ASSUME_NONNULL_BEGIN


@interface PSBaseAPI : NSObject
//PSCGIRequestMask Response 自定义
+ (NSURLSessionDataTask *)post:(NSString *)URLString
             JZTCGIRequestMask:(PSCGIRequestMask )requestType
                    parameters:(id)parameters
                           cls:(Class)cls
                       success:(PSCGISuccessBlock)success
                       failure:(PSCGIFaileBlock)failure;

//PSCGIRequestMask 默认
+ (NSURLSessionDataTask *)post:(NSString *)URLString
                    parameters:(id)parameters
                           cls:(Class)cls
                       success:(PSCGISuccessBlock)success
                       failure:(PSCGIFaileBlock)failure;

//Response 默认
+ (NSURLSessionDataTask *)post:(NSString *)URLString
             JZTCGIRequestMask:(PSCGIRequestMask )requestType
                    parameters:(id)parameters
                       success:(PSCGISuccessBlock)success
                       failure:(PSCGIFaileBlock)failure;

//PSCGIRequestMask Response 默认
+ (NSURLSessionDataTask *)post:(NSString *)URLString
                    parameters:(id)parameters
                       success:(PSCGISuccessBlock)success
                       failure:(PSCGIFaileBlock)failure;

+ (NSURLSessionDataTask *)get:(NSString *)URLString
            JZTCGIRequestMask:(PSCGIRequestMask )requestType
                   parameters:(id)parameters
                          cls:(Class)cls
                      success:(PSCGISuccessBlock)success
                      failure:(PSCGIFaileBlock)failure;

+ (NSURLSessionDataTask *)get:(NSString *)URLString
            JZTCGIRequestMask:(PSCGIRequestMask )requestType
                   parameters:(id)parameters
                      success:(PSCGISuccessBlock)success
                      failure:(PSCGIFaileBlock)failure;


/*
 文件下载
 */
+(NSURLSessionDownloadTask*)downLoadFile:(NSString*)fileUrl complet:(PScompletionHandler)handeler;

@end

NS_ASSUME_NONNULL_END
