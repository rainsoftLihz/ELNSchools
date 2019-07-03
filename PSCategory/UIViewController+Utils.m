#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)


+ (UIViewController *)presentingVC{

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    return result;
}

#pragma mark --- 获取当前对应的VC
+(UIViewController *)getCurrentViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //1、通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        //2、通过navigationcontroller弹出VC
        NSLog(@"subviews == %@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
        if(![nextResponder isKindOfClass:[UIViewController class]])
        {
             nextResponder = window.rootViewController;
        }
    }
    //1、tabBarController
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //或者 UINavigationController * nav = tabbar.selectedViewController;
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        //2、navigationController
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{//3、viewControler
        result = nextResponder;
    }
    return result;
//    UIViewController* activityViewController = nil;
//
//    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    if(window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow *tmpWin in windows)
//        {
//            if(tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//
//    NSArray *viewsArray = [window subviews];
//    if([viewsArray count] > 0)
//    {
//        UIView *frontView = [viewsArray objectAtIndex:0];
//
//        id nextResponder = [frontView nextResponder];
//
//        if([nextResponder isKindOfClass:[UIViewController class]])
//        {
//            activityViewController = nextResponder;
//        }
//        else
//        {
//            activityViewController = window.rootViewController;
//        }
//    }
//
//    while (activityViewController.presentedViewController) {
//        activityViewController = activityViewController.presentedViewController;
//    }
//    if ([activityViewController isKindOfClass:[UITabBarController class]]) {
//        activityViewController = [((UITabBarController*)activityViewController) selectedViewController];
//    }
//    if ([activityViewController isKindOfClass:[UINavigationController class]]) {
//        activityViewController = [((UINavigationController*)activityViewController) visibleViewController];
//    }
//    return activityViewController;
}

@end
