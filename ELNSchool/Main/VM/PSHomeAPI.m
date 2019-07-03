//
//  PSHomeAPI.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSHomeAPI.h"

@implementation PSHomeAPI

+(void)getHomeDataSuccess:(PSCGISuccessBlock)success faile:(PSCGIFaileBlock)faile{
    [self post:@"/elnApi/api/portalSetting.action" parameters:@{@"m":@"getAPPMainPageDataCPIC"} cls:[PSHomeModel class] success:^(NSURLSessionDataTask *task, id response) {
        success(task,response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        faile(task,error);
    }];
}

@end
