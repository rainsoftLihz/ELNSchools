//
//  JZTLoginVController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/5.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "JZTLoginVController.h"
#import "PSCodeVController.h"
#import "PSLoginAPI.h"
@interface JZTLoginVController ()
/* 电话号码 */
@property (nonatomic,strong)NSString* phoneStr;
/* 密码 */
@property (nonatomic,strong)NSString* passwdStr;
/* 短信验证码 */
@property (nonatomic,strong)NSString* verifyStr;
@end

@implementation JZTLoginVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configHeaderWith:@"登录"];
    
    [self.tableView reloadData];
    
    [self configBottomActionBtnWithTitle:@"登录"];
}

#pragma mark ---  初始化数据

-(NSArray *)iconArr
{

    return @[@"Phone",@"Key"];
   
}

-(NSArray *)placeHolderArr
{
    return @[@"请输入您的手机号",@"请输入您的验证码"];
}

#pragma mark --- table
-(void)configCell:(JZTLoginViewCell *)cell andIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [cell configTextFild:self.phoneStr];
        [cell changeInputKeyBoard];
    }
    else {
       
       [cell configTextFild:self.verifyStr];
       
    }
    
    if ( indexPath.row == 0) {
        /* 快速登录为3 */
        [cell addSendMessageBtnWithType:@"3"];
        
    }
    
    
    __weak typeof(self)wkSelf = self;
    cell.backText = ^(NSString* text){
        if (indexPath.row == 0) {
            wkSelf.phoneStr = text;
        }
        else {
            
            wkSelf.verifyStr = text;
           
        }
    };
}


#pragma mark ---   登录
-(void)bottomBigBtnClick{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    
    animation.type = @"rippleEffect";
    
    animation.subtype = kCATransitionFromTop;
    
    [self presentViewController:[PSCodeVController new] animated:YES completion:nil];
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    
    
    if (!self.phoneStr || !self.verifyStr){
        return;
    }

    
    [PSLoginAPI loginWith:@{@"mobile":self.phoneStr,@"inputCode":self.verifyStr,@"coopCode":@"shuiwu"} Success:^(NSURLSessionDataTask *task, id response) {
        
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


#pragma mark --- 邀请码

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
