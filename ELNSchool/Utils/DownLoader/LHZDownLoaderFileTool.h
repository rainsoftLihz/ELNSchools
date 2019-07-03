//
//  PSFileTool.h
//  ELNSchool
//
//  Created by rainsoft on 2019/6/14.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kTmpPath NSTemporaryDirectory()

NS_ASSUME_NONNULL_BEGIN

@interface LHZDownLoaderFileTool : NSObject

+ (BOOL)isFileExists: (NSString *)path;

+ (long long)fileSizeWithPath: (NSString *)path;

+ (void)moveFile:(NSString *)fromPath toPath: (NSString *)toPath;

+ (void)removeFileAtPath: (NSString *)path;



+ (NSString *)cachePathWithURL: (NSURL *)url;

+ (NSString *)tmpPathWithURL: (NSURL *)url;

+ (BOOL)isCacheFileExists: (NSURL *)url;

+ (BOOL)isTmpFileExists: (NSURL *)url;

+ (long long)cacheFileSizeWithURL: (NSURL *)url;

+ (NSString *)contentTypeWithURL: (NSURL *)url;

@end

NS_ASSUME_NONNULL_END
