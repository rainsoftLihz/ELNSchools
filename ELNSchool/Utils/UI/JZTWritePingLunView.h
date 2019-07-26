//
//  JZTWritePingLunView.h
//  qmyios
//
//  Created by rainsoft on 2017/5/31.
//  Copyright © 2017年 九州通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTWritePingLunView : UIView

@property(nonatomic,copy) void(^submitPingLunText)(NSString *info);

/* 清空视图内容 */
-(void)clearView;

/* 弹出键盘 */
-(void)beFirstResponder;

@end
