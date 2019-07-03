//
//  PSRootViewController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSRootViewController.h"
#import "PSMainVController.h"
#import "PSMineVController.h"
#import "PSCollegeVController.h"
@interface PSRootViewController ()

@end

@implementation PSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configTab];
}

#pragma mark -  初始化数据
-(NSArray*)titleAry{
    return @[@"课程",@"学院",@"我的"];
}

-(NSArray*)imgNomalAry{
    return @[@"main_n",@"library_n",@"me_n"];
}

-(NSArray*)imgSelectAry{
    return @[@"main_s",@"library_sel",@"me_sel"];
}

-(NSArray*)viewControllerAay{
    return @[@"PSMainVController",@"PSCollegeVController",@"PSMineVController"];
}


#pragma mark -  配置底部按钮
- (void)configTab {
    
    NSMutableArray *vcs = [NSMutableArray array];
    
    for (int i = 0;i < self.viewControllerAay.count; i++ ) {
        
        NSString *vcStr = self.viewControllerAay[i];
        Class viewController =  NSClassFromString(vcStr);
        
        PSBaseViewController *vc = (PSBaseViewController *)[[viewController alloc]init];
        vc.tabBarItem.title = self.titleAry[i];
        vc.navigationItem.title = self.titleAry[i];;
        vc.tabBarItem.selectedImage = [UIImage imageNamed:self.imgSelectAry[i]];
        vc.tabBarItem.image = [UIImage imageNamed:self.imgNomalAry[i]];
        //隐藏默认的返回按钮
        vc.navigationItem.hidesBackButton = YES;
        PSNavViewController *nav = [[PSNavViewController alloc]initWithRootViewController:vc];
        [vcs addObject:nav];
    }
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [[UIColor alloc]initWithRed:33/255.0 green:150/255.0 blue:223/255.0 alpha:1];
    self.selectedIndex = 0;
    self.viewControllers = vcs;
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
