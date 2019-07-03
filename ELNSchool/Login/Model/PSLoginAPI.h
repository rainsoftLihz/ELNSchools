//
//  PSLoginAPI.h
//  PacificSchool
//
//  Created by rainsoft on 2019/6/5.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseAPI.h"
#import "PSFrontPartner.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LoginType){
    kLoginTypeRegister,
    kLoginTypeLogin
};

@interface PSLoginAPI : PSBaseAPI

+(void)loginWith:(NSDictionary*)params Success:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile;

+(void)getMessageCodeWith:(NSDictionary*)params Success:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile;

+(void)checkCodeWith:(NSDictionary*)params Success:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile;

//微信登录
+(void)weChatLoginWith:(NSDictionary*)params Success:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile;
@end

NS_ASSUME_NONNULL_END
