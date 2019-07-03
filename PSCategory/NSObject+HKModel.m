//
//  NSObject+HKModel.m
//  qmyios
//
//  Created by 黄康 on 16/12/29.
//  Copyright © 2016年 九州通. All rights reserved.
//

#import "NSObject+HKModel.h"

@implementation NSObject (HKModel)

+ (id) modelWithArrayOrNSDictionary:(NSObject *)obj{
    if (!obj || obj == (id)kCFNull) return nil;
   
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return [self modelWithDictionary:(NSDictionary *)obj];
    }else if([obj isKindOfClass:[NSArray class]]){
        return [self modelArrayWithArray:(NSArray *)obj];
    }else{
        //如果不是字典也是数组 原样返回
        return obj;
    }
}

+ (NSArray *) modelArrayWithArray:(NSArray *)array{
    if (!array || array == (id)kCFNull) return nil;
    if (![array isKindOfClass:[NSArray class]]) return nil;
    if (array.count == 0) return nil;
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        NSObject *tempObj = [self modelWithDictionary:dict];
        if(tempObj){
            [modelArray addObject:tempObj];
        }
    }
    return modelArray;
}
@end
