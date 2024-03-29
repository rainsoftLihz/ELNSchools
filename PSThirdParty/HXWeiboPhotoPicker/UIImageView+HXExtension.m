//
//  UIImageView+HXExtension.m
//  微博照片选择
//
//  Created by 洪欣 on 2018/2/14.
//  Copyright © 2018年 洪欣. All rights reserved.
//

#import "UIImageView+HXExtension.h"

#import "HXPhotoModel.h"

#if __has_include(<SDWebImage/UIImageView+WebCache.h>)
#import <SDWebImage/UIImageView+WebCache.h>
#else
#import "UIImageView+WebCache.h"
#endif

@implementation UIImageView (HXExtension)
- (void)hx_setImageWithModel:(HXPhotoModel *)model progress:(void (^)(CGFloat progress, HXPhotoModel *model))progressBlock completed:(void (^)(UIImage * image, NSError * error, HXPhotoModel * model))completedBlock {
    __weak typeof(self) weakSelf = self;
//    [YYWebImageManager sharedManager].cache.decodeForDisplay = NO;
//    [self setImageWithURL:model.networkPhotoUrl placeholder:model.thumbPhoto options:YYWebImageOptionIgnoreDiskCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        model.receivedSize = receivedSize;
//        model.expectedSize = expectedSize;
//        CGFloat progress = 0.;
//        if (expectedSize > 0) {
//            progress = (CGFloat)receivedSize / expectedSize;
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (progressBlock) {
//                progressBlock(progress, model);
//            }
//        });
//
//    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//        if (error != nil) {
//            model.downloadError = YES;
//            model.downloadComplete = YES;
//        }else {
//            if (image) {
//                weakSelf.image = image;
//                model.imageSize = image.size;
//                model.thumbPhoto = image;
//                model.previewPhoto = image;
//                model.downloadComplete = YES;
//                model.downloadError = NO;
//            }
//        }
//        if (completedBlock) {
//            completedBlock(image,error,model);
//        }
//
//    }];
    
    [SDWebImageManager sharedManager].imageCache.config.shouldDecompressImages = NO;
    [SDWebImageDownloader sharedDownloader].shouldDecompressImages = NO;
    [self sd_setImageWithURL:model.networkPhotoUrl placeholderImage:model.thumbPhoto options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        model.receivedSize = receivedSize;
        model.expectedSize = expectedSize;
        CGFloat progress = 0.;
        if (expectedSize > 0) {
            progress = (CGFloat)receivedSize / expectedSize;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(progress, model);
            }
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error != nil) {
            model.downloadError = YES;
            model.downloadComplete = YES;
        }else {
            if (image) {
                if ([weakSelf.superview.superview isKindOfClass:NSClassFromString(@"HXPhotoSubViewCell")]) {
                    
                    
                }else{
                    model.imageSize = image.size;
                    model.thumbPhoto = image;
                    model.previewPhoto = image;
                    model.downloadComplete = YES;
                    model.downloadError = NO;
                }
            }
        }
        if (completedBlock) {
            completedBlock(image,error,model);
        }
    }];
}
@end
