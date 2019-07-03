//
//  JZTLoginViewCell.h
//  JK_BLB
//
//  Created by rainsoft on 16/12/1.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZTLoginViewCell;
@protocol JZTLoginProtocol <NSObject>

-(void)textChange:(UITextField*)textf andCell:(JZTLoginViewCell*)cell;

@end

@interface JZTLoginViewCell : UITableViewCell

@property (nonatomic,copy) void(^backText)(NSString*);

-(void)setUIWithIconStr:(NSString*)imgStr andPlaceHolderStr:(NSString*)placeHolder;

/* 保存输入的text的值 只有登录界面需要 */
-(void)configTextFild:(NSString*)text;

/*  是否需要密文输入 */
-(void)needSecretInput;
/*  修改键盘样式 */
-(void)changeInputKeyBoard;
/* 是否允许输入 */
-(void)changeTextfildUserInteraction:(BOOL)enabled;

-(void)addSendMessageBtnWithType:(NSString*)messageType;

+(CGFloat)cellHeight;

@end
