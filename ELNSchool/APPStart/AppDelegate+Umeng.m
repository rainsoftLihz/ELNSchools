//
//  AppDelegate+Umeng.m
//  huyaobang
//
//  Created by powerful on 2018/6/19.
//  Copyright © 2018年 JZT. All rights reserved.
//

#import "AppDelegate+Umeng.h"

#define kUmengAppKey @"5d1acf1e4ca3577041000f05"
#define kWXAppID @"wx6621f31d75851fc2"
#define kWXAppSecret @"46c56d880a23fdab7ef401462189c9f6"
@implementation AppDelegate (Umeng)

- (void)umengTrack {
    
    [UMConfigure initWithAppkey:kUmengAppKey
                        channel:@"App Store"];
    
    
    [UMConfigure setLogEnabled:YES];

    //设置微信appKey和appSecret  URL必须写否则没有回调
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:kWXAppID
                                       appSecret:kWXAppSecret
                                     redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //注册微信
    [WXApi registerApp:kWXAppID];
    
    NSLog(@"初始化友盟完成");
}

@end
