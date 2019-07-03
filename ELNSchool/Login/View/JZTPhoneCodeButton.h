//
//  JZTPhoneCodeButton.h
//  qmyios
//
//  Created by 李彪 on 2017/1/6.
//  Copyright © 2017年 九州通. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 发送验证码按钮
 */
@interface JZTPhoneCodeButton : UIButton

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSTimeInterval durationToValidity;
//倒计时完成
@property (nonatomic, copy) void(^countdownFinishBlock)(void);

/**
 开启定时器
 durationToValidity 倒计时时间
*/
- (void)startUpTimerWithDurationToValidity:(NSTimeInterval)durationToValidity;
/**
 销毁定时器
 */
- (void)invalidateTimer;

@end
