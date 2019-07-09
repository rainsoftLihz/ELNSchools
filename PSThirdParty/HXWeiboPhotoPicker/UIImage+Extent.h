//
//  UIImage+Extent.h
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/7/9.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extent)
- (UIImage *)compressWithWidth:(CGFloat)width;
+ (UIImage *)compressWithData:(NSData *)data width:(CGFloat)width;
@end
