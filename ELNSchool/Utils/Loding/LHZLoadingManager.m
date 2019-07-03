//
//  LHZLoadingManager.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/25.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "LHZLoadingManager.h"

@implementation LHZLoadingManager

#pragma mark  --- 数据加载
+(void)showLoading:(NSString*)msg{
    [SVProgressHUD showWithStatus:msg];
}

+(void)showLoading:(NSString*)msg to:(UIView*)view{
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:msg];
}

#pragma mark --- 普通提示信息
+(void)showTips:(NSString*)tips{
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:tips];
}

+(void)showTips:(NSString*)tips to:(UIView*)view{
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:tips];
}


#pragma mark --- 成功提示信息
+(void)showTipsSuccess:(NSString*)tips{
    [SVProgressHUD setMaximumDismissTimeInterval:2.0];
    [SVProgressHUD showSuccessWithStatus:tips];
}

+(void)showTipsSuccess:(NSString*)tips to:(UIView*)view{
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showSuccessWithStatus:tips];
}

#pragma mark --- 错误提示信息
+(void)showTipsError:(NSString*)tips{
    [SVProgressHUD showErrorWithStatus:tips];
}

+(void)showTipsError:(NSString*)tips to:(UIView*)view{
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showErrorWithStatus:tips];
}


@end
