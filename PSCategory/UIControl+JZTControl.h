//
//  UIControl+JZTControl.h
//  GongYinShang
//
//  Created by rainsoft on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UIControl (JZTControl)

@property (nonatomic, assign) NSTimeInterval acceptEventInterval;

@property (nonatomic, assign) BOOL ignoreEvent;

@end
