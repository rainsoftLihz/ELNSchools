//
//  PSLoginManager.h
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSFrontPartner.h"
NS_ASSUME_NONNULL_BEGIN

#define kFrontUserId @"frontUserId"

#define kAccessToken @"accessToken"

#define kFrontUser @"frontUser"

@interface PSLoginManager : NSObject
//手机号
@property(nonatomic,strong) NSString* mobile;

//coopCode
@property(nonatomic,strong) NSString* coopCode;
//邀请码
@property(nonatomic,strong) NSString* partnerNo;

+ (instancetype)manager;

+(void)saveFrontUser:(PSFrontPartner *)frontUser;

+(PSFrontPartner*)frontUser;

+(NSString*)mobile;

+(BOOL)isLogin;
@end

NS_ASSUME_NONNULL_END
