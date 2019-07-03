//
//  UIView+JZTCateGory.h
//  JZTCategory
//
//  Created by rainsoft on 2018/5/18.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JZTCateGory)

@property (nonatomic) CGPoint viewOrigin;
@property (nonatomic) CGSize  viewSize;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat centerYInSelf;

/*----------------------
 * Relative coordinate *
 ----------------------*/

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;

//一次添加多个视图
-(void)addSubViews:(NSArray *)subViews;
//获取view对应的控制器
- (UIViewController*)viewController;
@end
