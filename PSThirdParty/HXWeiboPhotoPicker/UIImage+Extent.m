//
//  UIImage+Extent.m
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/7/9.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import "UIImage+Extent.h"

@implementation UIImage (Extent)
- (UIImage *)compressWithWidth:(CGFloat)aWidth{
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    float width = aWidth;
    float height = self.size.height/(self.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, self.scale);
//    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [self drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [self drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)compressWithData:(NSData *)data width:(CGFloat)width{
    UIImage *image = [[UIImage alloc]initWithData:data];
    if (!image) {
        return nil;
    }
    return [image compressWithWidth:width];
    
}
@end
