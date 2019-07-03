//
//  PSBaseAPI.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseAPI.h"
#import "NSObject+YYModel.h"
#import "NSObject+HKModel.h"
#import "PSLoginManager.h"
@implementation PSBaseAPI

+ (NSURLSessionDataTask *)post:(NSString *)URLString
             JZTCGIRequestMask:(PSCGIRequestMask )requestType
                    parameters:(id)parameters
                           cls:(Class)cls
                       success:(PSCGISuccessBlock)success
                       failure:(PSCGIFaileBlock)failure{
    
    PSCGIManager *manager = [PSCGIServer CGIManagerWithMask:requestType];
    
    parameters = [self appendGlobalParams:parameters];
   
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        PSRsponse *response = [PSRsponse modelWithDictionary:responseObject];
      
        if (cls) {
            response.data = [cls modelWithArrayOrNSDictionary:response.data];
        }
        success(task,response);
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

+ (NSURLSessionDataTask *)post:(NSString *)URLString
                    parameters:(id)parameters
                           cls:(Class)cls
                       success:(PSCGISuccessBlock)success
                       failure:(PSCGIFaileBlock)failure{
    
    PSCGIManager *manager = [PSCGIServer CGIManagerWithMask:PSCGIRequestMaskDefult];
    
    parameters = [self appendGlobalParams:parameters];
    
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        PSRsponse *response = [PSRsponse modelWithDictionary:responseObject];
        
        if (cls) {
            response.data = [cls modelWithArrayOrNSDictionary:response.data];
        }
        success(task,response);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}


+ (NSURLSessionDataTask *)post:(NSString *)URLString
             JZTCGIRequestMask:(PSCGIRequestMask )requestType
                    parameters:(id)parameters
                       success:(PSCGISuccessBlock)success
                       failure:(PSCGIFaileBlock)failure{
    
    PSCGIManager *manager = [PSCGIServer CGIManagerWithMask:requestType];
    
    parameters = [self appendGlobalParams:parameters];
    
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        PSRsponse *response = [PSRsponse modelWithDictionary:responseObject];
        success(task,response);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

+ (NSURLSessionDataTask *)post:(NSString *)URLString
                    parameters:(id)parameters
                       success:(PSCGISuccessBlock)success
                       failure:(PSCGIFaileBlock)failure{
    
    PSCGIManager *manager = [PSCGIServer CGIManagerWithMask:PSCGIRequestMaskDefult];
    
    parameters = [self appendGlobalParams:parameters];
    
    [SVProgressHUD show];
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        [SVProgressHUD dismiss];
        PSRsponse *response = [PSRsponse modelWithDictionary:responseObject];
        success(task,response);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}



+ (NSURLSessionDataTask *)get:(NSString *)URLString
             JZTCGIRequestMask:(PSCGIRequestMask )requestType
                    parameters:(id)parameters
                           cls:(Class)cls
                      success:(PSCGISuccessBlock)success
                      failure:(PSCGIFaileBlock)failure{
    
    PSCGIManager *manager = [PSCGIServer CGIManagerWithMask:requestType];
    
    parameters = [self appendGlobalParams:parameters];
    
    return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        PSRsponse *response = [PSRsponse modelWithDictionary:responseObject];
        
        if (cls) {
            response.data = [cls modelWithArrayOrNSDictionary:response.data];
        }
        
        success(task,response);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

+ (NSURLSessionDataTask *)get:(NSString *)URLString
            JZTCGIRequestMask:(PSCGIRequestMask )requestType
                   parameters:(id)parameters
                      success:(PSCGISuccessBlock)success
                      failure:(PSCGIFaileBlock)failure{
    
    PSCGIManager *manager = [PSCGIServer CGIManagerWithMask:requestType];
    
    parameters = [self appendGlobalParams:parameters];
    
    return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        PSRsponse *response = [PSRsponse modelWithDictionary:responseObject];

        success(task,response);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}



/**
 追加公共参数
 
 @param parameters 来源参数
 @return 添加完公共参数的字典
 */
+ (NSDictionary *)appendGlobalParams:(NSDictionary *)parameters {
    
    NSMutableDictionary *dict = parameters ? [NSMutableDictionary
                                              dictionaryWithDictionary:parameters] : [NSMutableDictionary new ];
    //平台 （platform  为1iOS，为2安卓）
    [dict setObject:@(1) forKey:@"platform"];
    
    PSFrontPartner* frontUser = [PSLoginManager frontUser];
    
    BOOL flag = ![Utils isBlankString:frontUser.frontUserId];
    if (frontUser != nil &&  flag) {
        NSDictionary *commParam = @{ @"frontUserId" : frontUser.frontUserId, @"accessToken" : frontUser.accessToken,@"coopCode":frontUser.coopCode};
        
        [dict addEntriesFromDictionary:commParam];
    }
    
    return dict;
}


/**
 downLoad文件
 */

+(NSURLSessionDownloadTask*)downLoadFile:(NSString*)fileUrl complet:(PScompletionHandler)handeler{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //中文转还
    NSURL *URL = [NSURL URLWithString:[fileUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //保存文件名
    NSString *fileName = [fileUrl lastPathComponent];
    
    [SVProgressHUD showWithStatus:@"文件下载中..."];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        //存储路径
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
        return url;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [SVProgressHUD dismiss];
        //回调
        handeler(response,filePath,error);
    }];
    [downloadTask resume];
    
    return  downloadTask;
}

@end
