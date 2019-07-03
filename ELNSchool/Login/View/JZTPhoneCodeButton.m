//
//  JZTPhoneCodeButton.m
//  qmyios
//
//  Created by 李彪 on 2017/1/6.
//  Copyright © 2017年 九州通. All rights reserved.
//

#import "JZTPhoneCodeButton.h"
@interface JZTPhoneCodeButton ()

@end

@implementation JZTPhoneCodeButton

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    if (enabled) {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:UIColorFromRGB(0x4e4e4e) forState:UIControlStateNormal];
    }
}

- (void)startUpTimerWithDurationToValidity:(NSTimeInterval)durationToValidity{
    _durationToValidity = durationToValidity ? :60;
    self.enabled = NO;
    [self setTitleColor:UIColorFromRGB(0x2b2b2b) forState:UIControlStateNormal];
    
    NSInteger restTime = _durationToValidity;
    [self setTitle:[NSString stringWithFormat:@"%ld秒",restTime] forState:UIControlStateNormal];
    if([self.timer isValid]){
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (@available(iOS 10.0, *)) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self redrawTimer];
        }];
    } else {
        // Fallback on earlier versions
    }
}



- (void)invalidateTimer{
    if (!self.isEnabled) {
        self.enabled = YES;
    }
    
    
    //倒计时完成回调
    if (self.countdownFinishBlock) {
        self.countdownFinishBlock();
    }
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)redrawTimer {
    _durationToValidity--;
   NSLog(@"定时器执行中：%lf",_durationToValidity);
    if (_durationToValidity > 0) {
        NSInteger restTime = _durationToValidity;
        self.titleLabel.text = [NSString stringWithFormat:@"%ld秒", restTime];//防止 button_title 闪烁
        [self setTitle:[NSString stringWithFormat:@"%ld秒", restTime] forState:UIControlStateNormal];
        
    }else{
        [self invalidateTimer];
    }
}

@end
