//
//  PSPhoneController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSPhoneController.h"
#import "PSCodeVController.h"
#import "PSLoginBaseView.h"
#import "PSMessageController.h"
#import <UMShare/UMShare.h>
@interface PSPhoneController ()

@end

@implementation PSPhoneController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self configHeaderWith:@"请输入您的手机号"];
    [self configBottomActionBtnWithTitle:@"下一步"];
    
    WeakSelf;
    PSLoginBaseView* phoneView = [[PSLoginBaseView alloc] initWithFrame:CGRectMake(0, [self contentSpace], KScreenWidth, 49.0) andIcon:@"Phone" andPlacehold:@"请输入手机号" andBlock:^(NSString * phoneStr) {
        
        [PSLoginManager manager].mobile = phoneStr;
        
        if ([Utils validateMobile:phoneStr]){
            wkSelf.nextBtn.enabled = YES;
            wkSelf.nextBtn.backgroundColor = UIColor.redColor;
        }else {
            wkSelf.nextBtn.enabled = NO;
            wkSelf.nextBtn.backgroundColor = UIColor.grayColor;
        }
    }];
    [self.view addSubview:phoneView];
  
    
    //添加微信登录
    UILabel* thirdPartLab = [[UILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:15.0] textColor:UIColor.blackColor];
    thirdPartLab.text = @"———— 更多登录方式 ————";
    [self.view addSubview:thirdPartLab];
    UIButton* wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxBtn setImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(wxLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxBtn];
    
    [thirdPartLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nextBtn.mas_bottom).offset(Adapt_scaleV(90));
        make.centerX.equalTo(self.view);
        make.height.with.mas_equalTo(Adapt_scaleL(30));
    }];
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdPartLab.mas_bottom).offset(Adapt_scaleV(15));
        make.centerX.equalTo(self.view);
        make.height.with.mas_equalTo(@45);
        make.width.with.mas_equalTo(@45);
    }];
    
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        thirdPartLab.hidden = NO;
        wxBtn.hidden = NO;
    } else {
        thirdPartLab.hidden = YES;
        wxBtn.hidden = YES;
    }
}


#pragma mark --- 微信登录
-(void)wxLogin{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"error=%@",error);
        } else {
            UMSocialUserInfoResponse *infoResponse = result;
            if (infoResponse.uid) {
                [self weChatLoginWith:infoResponse];
            } else {
                [LHZLoadingManager  showTipsError:@"微信登录失败"];
            }
        }
    }];
}

- (void)weChatLoginWith:(UMSocialUserInfoResponse*)response {
    
    [PSLoginAPI weChatLoginWith:[response modelToJSONObject] Success:^(NSURLSessionDataTask *task, id response) {
        
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


#pragma mark --- 下一步
-(void)nextBtnClick{
    [self.view endEditing:YES];
    NSString* md5Str = [NSString stringWithFormat:@"%@%@",[PSLoginManager manager].mobile,MD5_SCRECT_CODE];
    NSDictionary* params = @{@"mobile":[PSLoginManager manager].mobile,
                             @"verifyCode":[Utils md5:md5Str]};
  
    [PSLoginAPI getMessageCodeWith:params Success:^(NSURLSessionDataTask *task, PSRsponse* response) {
     
        if ([response.ret isEqualToString:@"-1"] && [response.err_code isEqualToString:@"9992"]) {
            //未注册并没有邀请码 跳转到邀请码
            [self presentViewController:[PSCodeVController new] animated:YES completion:nil];
        }else {
            //获取验证码
            NSString* coopCode = response.data[@"coopCode"];
            if ([Utils isBlankString:coopCode]) {
                [SVProgressHUD showErrorWithStatus:@"coopCode返回为空"];
            }else {
                [PSLoginManager manager].coopCode = coopCode;
                [self presentViewController:[PSMessageController new] animated:YES completion:nil];
            }
        }
        
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
