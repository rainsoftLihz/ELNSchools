//
//  PSMacroUtils.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#ifndef PSMacroUtils_h
#define PSMacroUtils_h

#define MD5_SCRECT_CODE @"@safty@"

#pragma mark - User相关


#define USERDEFAULTS_GET_OBJECT(key)  [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define kUserDefaults [NSUserDefaults standardUserDefaults]


#define USERDEFAULTS_SET_OBJECT(object, key)                          \
({                                                                      \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
[defaults setObject:object forKey:key];                                 \
[defaults synchronize];                                                  \
})

#define kWeakSelf __weak typeof(self) wkSelf = self;


#pragma mark - 屏幕相关

#define kWProportion (KScreenWidth/1242)

#define kHProportion (KScreenHeight/2208)

//设备的尺寸
#define KScreenBounds [UIScreen mainScreen].bounds
//设备的高度
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
//设备的宽度
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
//ISIphoneX
#define kISIphoneX ([[UIApplication sharedApplication]statusBarFrame].size.height == 44)

#define kStatusBarH ([[UIApplication sharedApplication]statusBarFrame].size.height)


#define kNavBarAndStatusBarHeight (CGFloat)(kISIphoneX?(88.0):(64.0))


#define kTabBarHeight (CGFloat)(kISIphoneX?(49.0 + 34.0):(49.0))

#define kSafeBottomArea (kISIphoneX?34:0)


#pragma mark - 颜色类
//UIColor *color=UIColorFromRGB(0xDDEEFF)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]


#define kMainColor UIColorFromRGB(0x007ED9)

#define kFontSize(size) [UIFont systemFontOfSize:size]
#define kFontBoldSize(size) [UIFont boldSystemFontOfSize:size]

#define kUIImage(name) [UIImage imageNamed:name]


/// 微信支付通知
#define WX_PAY_NOTIFICATION @"WX_PAY_NOTIFICATION"

#endif /* PSMacroUtils_h */
