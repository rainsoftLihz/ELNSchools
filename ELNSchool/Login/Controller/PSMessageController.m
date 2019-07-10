//
//  PSMessageController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSMessageController.h"
#import "PSInPutCodeView.h"
#import "AppDelegate.h"
@interface PSMessageController ()
@property(nonatomic,strong) NSString* inputCode;
@end

@implementation PSMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configHeaderWith:@"请输入短信验证码"];
    
    kWeakSelf;
    PSInPutCodeView* psView = [[PSInPutCodeView alloc] initWithFrame:CGRectMake(0, [self contentSpace], KScreenWidth, 49) andCount:4 andSpace:8 codeBlock:^(NSString * code) {
        NSLog(@"code === %@",code);
        wkSelf.inputCode = code;
        if (code.length == 4){
            wkSelf.nextBtn.enabled = YES;
            wkSelf.nextBtn.backgroundColor = UIColor.redColor;
        }else {
            wkSelf.nextBtn.enabled = NO;
            wkSelf.nextBtn.backgroundColor = UIColor.grayColor;
        }
    }];
    [self.view addSubview:psView];
    
    [self configBottomActionBtnWithTitle:@"确定"];
    [self configBackItem];
}

-(void)nextBtnClick{
    
    NSString* md5Str = [NSString stringWithFormat:@"%@%@%@",[PSLoginManager mobile],self.inputCode,MD5_SCRECT_CODE];
    NSDictionary* params = @{@"mobile":[PSLoginManager mobile],
                             @"verifyCode":[Utils md5:md5Str],
                             @"partnerNo":[PSLoginManager manager].partnerNo?:@"",
                             @"inputCode":self.inputCode,
                             @"coopCode":[PSLoginManager manager].coopCode?:@""};
    
    [PSLoginAPI loginWith:params Success:^(NSURLSessionDataTask *task, id response) {
        
        PSRsponse* res = (PSRsponse*)response;
        if ([res.ret isEqualToString:@"0"]) {
            PSFrontPartner* frontUser = (PSFrontPartner*)res.data;
            //保存 frontUserId 和 accessToken;
            [PSLoginManager saveFrontUser:frontUser];
            
            //跳转到主界面
            [self goToHome];
        }
        
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)goToHome{
    [((AppDelegate *)[UIApplication sharedApplication].delegate) configTabbarRoot];
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
