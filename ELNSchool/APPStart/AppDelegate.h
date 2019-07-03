//
//  AppDelegate.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/8.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//当前UINavigationController
- (UINavigationController *)currentVC;
//登录成功后切换视图
-(void)configTabbarRoot;
@end

