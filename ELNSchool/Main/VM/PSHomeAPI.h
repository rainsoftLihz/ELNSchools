//
//  PSHomeAPI.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseAPI.h"
#import "PSHomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSHomeAPI : PSBaseAPI
+(void)getHomeDataSuccess:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile;
@end

NS_ASSUME_NONNULL_END
