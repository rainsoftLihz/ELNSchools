//
//  PSCodeVController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSCodeVController.h"
#import "PSInPutCodeView.h"
#import "PSMessageController.h"
@interface PSCodeVController ()

@end

@implementation PSCodeVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configHeaderWith:@"请输入邀请码"];
    
    __weak typeof(self)wkSelf = self;
    PSInPutCodeView* psView = [[PSInPutCodeView alloc] initWithFrame:CGRectMake(0, [self contentSpace], SCREEN_WIDTH, 49) andCount:4 andSpace:8 codeBlock:^(NSString * code) {
        NSLog(@"code === %@",code);
        [PSLoginManager manager].partnerNo = code;
        if (code.length == 4){
            wkSelf.nextBtn.enabled = YES;
            wkSelf.nextBtn.backgroundColor = UIColor.redColor;
        }else {
            wkSelf.nextBtn.enabled = NO;
            wkSelf.nextBtn.backgroundColor = UIColor.grayColor;
        }
    }];
    [self.view addSubview:psView];
    
    [self configBottomActionBtnWithTitle:@"下一步"];
    [self configBackItem];
}

- (void)nextBtnClick{
    NSString* md5Str = [NSString stringWithFormat:@"%@%@",[PSLoginManager manager].mobile,MD5_SCRECT_CODE];
    NSDictionary* params = @{@"mobile":[PSLoginManager mobile],
                             @"verifyCode":[Utils md5:md5Str],
                             @"partnerNo":[PSLoginManager manager].partnerNo};
    [PSLoginAPI checkCodeWith:params Success:^(NSURLSessionDataTask *task, PSRsponse* response) {
      
        if ([response.ret isEqualToString:@"0"]) {
            PSFrontPartner* front = (PSFrontPartner*)response.data;
            [PSLoginManager manager].coopCode = front.coopCode;
            [PSLoginManager manager].partnerNo = front.partnerNo;
            
            //短信
            [self presentViewController:[PSMessageController new] animated:YES completion:nil];
        }else {
            
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
