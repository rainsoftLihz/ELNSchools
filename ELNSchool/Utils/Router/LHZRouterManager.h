//
//  LHZRouterManager.h
//  ELNSchool
//
//  Created by rainsoft on 2019/6/25.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LHZRouterBlock) (id backData);

@interface UIViewController(LHZRouterManager)

@property (nonatomic,copy,nullable)LHZRouterBlock lhz_RouterBlock;

- (void)pushViewControllerName:(NSString *)vcName;

- (void)pushViewControllerName:(NSString *)vcName
                      animated:(BOOL)animated;

- (void)pushViewControllerName:(NSString *)vcName
                         param:(NSDictionary *)aParam;

- (void)pushViewControllerName:(NSString *)vcName
                         param:(NSDictionary *)aParam
                   routerBlock:(LHZRouterBlock)routerBlock;

- (void)pushViewControllerName:(NSString *)vcName
                         param:(NSDictionary *)aParam
                      animated:(BOOL)animated
                   routerBlock:(LHZRouterBlock)routerBlock;

@end

NS_ASSUME_NONNULL_END
