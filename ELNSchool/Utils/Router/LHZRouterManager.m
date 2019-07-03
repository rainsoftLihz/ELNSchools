//
//  LHZRouterManager.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/25.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "LHZRouterManager.h"
#import <objc/runtime.h>
#import "PSNavViewController.h"

typedef enum : NSUInteger {
    LHZRouterTypePush,
    LHZRouterTypePresent
} LHZRouterType;

@implementation UIViewController(LHZRouterManager)

#pragma mark ---- 属性赋值
- (void)paramToVc:(UIViewController *) v param:(NSDictionary *)parameters{
    if (parameters) {
        unsigned int outCount = 0;
        objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *key = [NSString stringWithUTF8String:property_getName(property)];
            NSString *param = parameters[key];
            if (param != nil) {
                [v setValue:param forKey:key];
            }
        }
    }
}

- (void)pushViewControllerName:(NSString * __nonnull)vcName {
    [self pushViewControllerName:vcName
                           param:nil
                        animated:YES
                     routerBlock:nil];
}

- (void)pushViewControllerName:(NSString * __nonnull)vcName
                      animated:(BOOL)animated {
    [self pushViewControllerName:vcName
                           param:nil
                        animated:animated
                     routerBlock:nil];
}

- (void)pushViewControllerName:(NSString * __nonnull)vcName
                         param:(NSDictionary *)aParam {
    [self pushViewControllerName:vcName
                           param:aParam
                        animated:YES
                     routerBlock:nil];
}

- (void)pushViewControllerName:(NSString * __nonnull)vcName
                         param:(NSDictionary * __nullable)aParam
                      animated:(BOOL)animated {
    [self pushViewControllerName:vcName
                           param:aParam
                        animated:animated
                     routerBlock:nil];
}

- (void)pushViewControllerName:(NSString *)vcName
                         param:(NSDictionary *)aParam
                   routerBlock:(LHZRouterBlock)routerBlock {
    [self routerViewControllerName:vcName
                             param:aParam
                        routerType:LHZRouterTypePush
                          animated:YES
                       routerBlock:routerBlock];
}


- (void)pushViewControllerName:(NSString *)vcName
                         param:(NSDictionary *)aParam
                      animated:(BOOL)animated
                   routerBlock:(LHZRouterBlock)routerBlock {
    [self routerViewControllerName:vcName
                                   param:aParam
                              routerType:LHZRouterTypePush
                                animated:animated
                             routerBlock:routerBlock];
}

- (void)presentViewControllerName:(NSString *)vcName
                            param:(NSDictionary *)aParam
                         animated:(BOOL)animated
                      routerBlock:(LHZRouterBlock)routerBlock {
    [self routerViewControllerName:vcName
                                   param:aParam
                              routerType:LHZRouterTypePresent
                                animated:animated
                             routerBlock:routerBlock];
}


- (void)routerViewControllerName:(NSString * __nonnull)vcName
                           param:(NSDictionary * __nullable)aParam
                      routerType:(LHZRouterType)rType
                        animated:(BOOL)animated
                     routerBlock:(LHZRouterBlock)routerBlock{
    //跳转
    //获取控制器
    Class cls = NSClassFromString(vcName);
    if (!cls) {
        return;
    }
    UIViewController *vc = [[cls alloc] init];
    [self paramToVc:vc param:aParam];
    if (rType == LHZRouterTypePush) {
        if ([self isKindOfClass:[UINavigationController class]]) {
            //当前控制器本身就是一个导航控制器
            [(UINavigationController *)self pushViewController:vc animated:animated];
            
        }else {
            //控制器存在堆栈中
            if (self.navigationController) {
                [self.navigationController pushViewController:vc animated:animated];
            }
        }
        
    }else {
        PSNavViewController *nav = [[PSNavViewController alloc] initWithRootViewController:vc];
        if ([self isKindOfClass:[UINavigationController class]]) {
            //当前控制器本身就是一个导航控制器
            [(UINavigationController *)self presentViewController:nav animated:animated completion:nil];
        }else {
            //控制器存在堆栈中
            if (self.navigationController) {
                [self.navigationController presentViewController:nav animated:animated completion:nil];
            }else {
                [self presentViewController:nav animated:animated completion:nil];
            }
        }
        
        
    }
    if (routerBlock) {
        [vc setLhz_RouterBlock:routerBlock];
    }
}




static char JZTCallBackBlockKey;

- (void)setLhz_RouterBlock:(LHZRouterBlock)lhz_RouterBlock {
    objc_setAssociatedObject(self, &JZTCallBackBlockKey, lhz_RouterBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (LHZRouterBlock)lhz_RouterBlock{
    return objc_getAssociatedObject(self, &JZTCallBackBlockKey);
}


@end
