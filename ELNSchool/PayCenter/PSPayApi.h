//
//  PSPayApi.h
//  ELNSchool
//
//  Created by rainsoft on 2019/7/10.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSPayApi : PSBaseAPI

+(void)payOrder:(NSDictionary*)param andSuccess:(PSCGISuccessBlock)sucess andFaile:(PSCGIFaileBlock)faile;

@end

NS_ASSUME_NONNULL_END
