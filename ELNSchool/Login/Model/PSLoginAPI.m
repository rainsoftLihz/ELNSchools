//
//  PSLoginAPI.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/5.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSLoginAPI.h"

@implementation PSLoginAPI

+(void)loginWith:(NSDictionary*)params Success:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile{
    
    [self post:@"/api/loginQuick.action?m=loginBySMSCode" parameters:params success:^(NSURLSessionDataTask *task, PSRsponse* response) {
        if (response.data) {
            response.data = [PSFrontPartner modelWithArrayOrNSDictionary:response.data[@"frontPartner"]];
        }
        success(task,response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        faile(task,error);
    }];
}

//获取短信
+(void)getMessageCodeWith:(NSDictionary*)params Success:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile{
  
    [self post:@"/api/loginQuick.action?m=getSMSCode" parameters:params success:^(NSURLSessionDataTask *task, id response) {
        success(task,response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        faile(task,error);
    }];
}


///api/frontPartner.action?m=getDetailByPartnerNo
//邀请码校验
+(void)checkCodeWith:(NSDictionary*)params Success:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile{
    
    [self post:@"/api/loginQuick.action?m=getDetailByPartnerNo" parameters:params success:^(NSURLSessionDataTask *task, PSRsponse* response) {
        if (response.data) {
            response.data = [PSFrontPartner modelWithArrayOrNSDictionary:response.data[@"frontPartner"]];
        }
        success(task,response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        faile(task,error);
    }];
}

+(void)weChatLoginWith:(NSDictionary*)params Success:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile{
    
    //http://ucenter.pomesoft.com/sems-ucenter/oauthApp.jhtml?m=getToken&coopCode=yunwang&code=
  
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://ucenter.pomesoft.com/sems-ucenter/oauthApp.jhtml" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faile(task,error);
    }];
}
@end
