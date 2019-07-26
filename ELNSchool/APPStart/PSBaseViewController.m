//
//  PSBaseViewController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseViewController.h"

@interface PSBaseViewController ()

@end

@implementation PSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    
    /* 坐标系从navigationBar开始 */
    self.navigationController.navigationBar.translucent = NO;
    
}

#pragma mark ---- 提示信息
-(void)showErrorMessage:(NSString*)message{
    [SVProgressHUD showErrorWithStatus:message];
}

-(void)dealloc{
    NSLog(@"销毁>>>>>>>%@",self);
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
