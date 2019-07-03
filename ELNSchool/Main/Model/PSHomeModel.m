//
//  PSHomeModel.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSHomeModel.h"

@implementation PSHomeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"elnMapList" : [PSelnMapModel class],
             @"elnCourseList2" : [PSCourseModel class],
             @"elnCourseList2" : [PSCourseModel class]
             };
}

@end
