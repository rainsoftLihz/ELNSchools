//
//  XTGradientLayer.h
//  PacificSchool
//
//  Created by Jonny on 2019/2/21.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSGradientLayer : NSObject
//添加渐变色
+ (CAGradientLayer*)getMainLayerWithFrame:(CGRect)rect;
+ (CAGradientLayer*)getGradientWithStart:(UIColor*)start end:(UIColor*)end WithFrame:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
