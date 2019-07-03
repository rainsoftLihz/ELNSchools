//
//  NSObject+HKModel.h
//  qmyios
//
//  Created by 黄康 on 16/12/29.
//  Copyright © 2016年 九州通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

@interface NSObject (HKModel)

/**
 将数组或者字典转换为数据模型数组或者数据模型

 @param obj 数组或者字典
 @return 数据模型数组或者数据模型
 */
+ (id) modelWithArrayOrNSDictionary:(NSObject *)obj;

/**
 将数组转换为数据模型数组

 @param array 数组
 @return 数据模型数组
 */
+ (NSArray *) modelArrayWithArray:(NSArray *)array;

@end
