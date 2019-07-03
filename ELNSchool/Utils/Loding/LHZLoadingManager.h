//
//  LHZLoadingManager.h
//  ELNSchool
//
//  Created by rainsoft on 2019/6/25.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHZLoadingManager : NSObject

#pragma mark  --- 数据加载
+(void)showLoading:(NSString*)msg;

+(void)showLoading:(NSString*)msg to:(UIView*)view;

#pragma mark --- 普通提示信息

+(void)showTips:(NSString*)tips;

+(void)showTips:(NSString*)tips to:(UIView*)view;

#pragma mark --- 成功提示信息
+(void)showTipsSuccess:(NSString*)tips;

+(void)showTipsSuccess:(NSString*)tips to:(UIView*)view;

#pragma mark --- 错误提示信息
+(void)showTipsError:(NSString*)tips;

+(void)showTipsError:(NSString*)tips to:(UIView*)view;
@end

NS_ASSUME_NONNULL_END
