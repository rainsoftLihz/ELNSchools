//
//  JZTLoginBaseVC.h
//  JK_BLB
//
//  Created by rainsoft on 16/12/1.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    kViewTypeLogin,/* 账号密码登录 */
    
    kViewTypeQuickLogin,/* 快捷登录 */
    
    kViewTypeRegistr,/* 注册 */
    
    kViewTypeRestPwd /* 重置密码 */
    
}kViewType;


#import "JZTLoginViewCell.h"



@interface JZTLoginBaseVC : UIViewController 

@property (nonatomic,strong)NSArray* iconArr;

@property (nonatomic,strong)NSArray* placeHolderArr;

@property (nonatomic,strong)UITableView* tableView;

-(CGFloat)headerTopSpace;

#pragma mark --- 返回
-(void)goBack:(UIButton*)senderBtn;

#pragma mark --- 配置CELL
-(void)configCell:(JZTLoginViewCell*)cell andIndexPath:(NSIndexPath *)indexPath;

#pragma mark --- 配置大的BTN
-(void)configBottomActionBtnWithTitle:(NSString*)title;
-(void)bottomBigBtnClick;

#pragma mark --- 配置头部视图
-(void)configHeaderWith:(NSString*)title;

@end
