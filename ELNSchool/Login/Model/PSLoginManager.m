//
//  PSLoginManager.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSLoginManager.h"

@implementation PSLoginManager

+ (instancetype)manager{
    static PSLoginManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PSLoginManager alloc] init];
    });
    return manager;
}



+(NSString*)mobile{
    return [PSLoginManager manager].mobile;
}


#pragma mark ---- 保存用户信息
+(PSFrontPartner*)frontUser{
    return USERDEFAULTS_GET_OBJECT(kFrontUser);
}

+(void)saveFrontUser:(PSFrontPartner *)frontUser{
    USERDEFAULTS_SET_OBJECT(frontUser, kFrontUser);
}

#pragma mark  --- 是否已经登录过
+(BOOL)isLogin{
    PSFrontPartner* frontUser = [PSLoginManager frontUser];
    if (frontUser && frontUser.frontUserId) {
        return YES;
    }
    return NO;
}

@end
