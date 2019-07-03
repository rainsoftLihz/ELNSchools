//
//  PSFileTool.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/14.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "LHZDownLoaderFileTool.h"

@implementation LHZDownLoaderFileTool

#pragma mark  ----  NSString Path
+ (BOOL)isFileExists: (NSString *)path {
    
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (long long)fileSizeWithPath: (NSString *)path {
    if (![self isFileExists:path]) {
        return 0;
    }
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    long long size = [fileInfo[NSFileSize] longLongValue];
    return size;
}

+ (void)moveFile:(NSString *)fromPath toPath: (NSString *)toPath {
    if (![self isFileExists:fromPath]) {
        return;
    }
    [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
}

+ (void)removeFileAtPath: (NSString *)path {
    if (![self isFileExists:path]) {
        return;
    }
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}


#pragma mark --- NSURL
+ (NSString *)cachePathWithURL: (NSURL *)url {
    return [kCachePath stringByAppendingPathComponent:url.lastPathComponent];
}

+ (NSString *)tmpPathWithURL: (NSURL *)url {
    return [kTmpPath stringByAppendingPathComponent:url.lastPathComponent];
}

+ (BOOL)isCacheFileExists: (NSURL *)url {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self cachePathWithURL:url]];
}

+ (BOOL)isTmpFileExists: (NSURL *)url {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self tmpPathWithURL:url]];
}

+ (NSString *)contentTypeWithURL: (NSURL *)url {
    
    NSString *fileExtension = url.absoluteString.pathExtension;
    
    CFStringRef contentTypeCF = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef _Nonnull)(fileExtension), NULL);
    
    NSString *contentType = CFBridgingRelease(contentTypeCF);
    
    return contentType;
    
}

+ (long long)cacheFileSizeWithURL: (NSURL *)url {
    
    
    if (![self isCacheFileExists:url]) {
        return 0;
    }
    
    NSString *path = [self cachePathWithURL:url];
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return  [fileInfo[NSFileSize] longLongValue];
    
}

+ (long long)tmpFileSizeWithURL: (NSURL *)url {
    
    if (![self isTmpFileExists:url]) {
        return 0;
    }
    NSString *path = [self tmpPathWithURL:url];
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return  [fileInfo[NSFileSize] longLongValue];
    
    
}

+ (void)removeTmpFileWithURL: (NSURL *)url {
    if ([self isTmpFileExists:url]) {
        
        [[NSFileManager defaultManager] removeItemAtPath:[self tmpPathWithURL:url] error:nil];
    }
}


+ (void)moveTmpPathToCachePath: (NSURL *)url {
    
    
    if ([self isTmpFileExists:url]) {
        NSString *tmpPath = [self tmpPathWithURL:url];
        NSString *cachePath = [self cachePathWithURL:url];
        
        [[NSFileManager defaultManager] moveItemAtPath:tmpPath toPath:cachePath error:nil];
    }
    
}

@end
