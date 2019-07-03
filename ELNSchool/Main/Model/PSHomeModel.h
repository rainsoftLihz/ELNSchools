//
//  PSHomeModel.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSCourseModel.h"
#import "PSHomeFrontUserModel.h"
#import "PSelnMapModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSHomeModel : NSObject

@property (nonatomic,strong)NSArray<PSelnMapModel*>* elnMapList;

@property (nonatomic,strong)NSArray<PSCourseModel*>* elnCourseList2;

@property (nonatomic,strong)NSArray<PSCourseModel*>* elnCourseList1;

@property (nonatomic,strong)PSHomeFrontUserModel* frontUserStatistics;

@property (nonatomic,strong)NSString* isSigned;

@property (nonatomic,strong)NSString* aimStudyTime;

@property (nonatomic,assign)NSInteger totalCoin;

@property (nonatomic,assign)NSInteger hasStudyTime;

@property (nonatomic,assign)NSInteger signTotalCount;
@end

NS_ASSUME_NONNULL_END
