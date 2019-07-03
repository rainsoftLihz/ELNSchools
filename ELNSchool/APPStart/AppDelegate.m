//
//  AppDelegate.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/8.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "AppDelegate.h"
#import "PSRootViewController.h"
#import "PSPhoneController.h"
#import "AppDelegate+Umeng.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    //友盟
    [self umengTrack];
    
    [self configRootViewController];
    
    return YES;
}


#pragma mark ---- root视图
- (void)configRootViewController{
    
    if ([PSLoginManager isLogin]) {
        [self configTabbarRoot];
    }else {
        [self configLoginRoot];
    }
}


- (void)configLoginRoot{
    
    PSPhoneController *loginVC = [[PSPhoneController alloc]init];
    
    self.window.rootViewController = loginVC;
    
    [self.window makeKeyAndVisible];
}



-(void)configTabbarRoot{
    PSRootViewController *tabBar = [[PSRootViewController alloc]init];
    
    tabBar.selectedIndex = 0;
    
    self.window.rootViewController = tabBar;
    
     [self.window makeKeyAndVisible];
}


#pragma mark ----
- (UINavigationController *)currentVC
{
    if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        
        return ((UITabBarController*)self.window.rootViewController).selectedViewController;
    }
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }else {
        
    }
    return result;
}

@end
