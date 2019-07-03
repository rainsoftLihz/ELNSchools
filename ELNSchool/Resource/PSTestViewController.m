//
//  PSTestViewController.m
//  ELNSchool
//
//  Created by rainsoft on 2019/6/25.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSTestViewController.h"
#import "LHZPlayerManger.h"
#import "LHZDownLoaderManager.h"

@implementation UserInfo


@end

@interface PSTestViewController ()

@end

@implementation PSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    //测试路由
    [self testRouter];
}

-(void)testDownLoader{

    NSString* url = @"http://audio.xmcdn.com/group55/M02/90/AA/wKgLf1yUdIzDELWBAGIa3y_-DnM545.m4a";
    url = @"http://audio.xmcdn.com/group57/M07/46/20/wKgLgVyd4_XDkM4XACOEyCgoA9A564.m4a";
    url = @"http://audio.xmcdn.com/group56/M06/62/D0/wKgLdlyfVwSyvtCcAJ4UntDw2vs694.m4a";
    
    [[LHZPlayerManger manger] playWithUrlstr:url isCache:YES];
    
    [[LHZDownLoaderManager manger] downLoadWithURL:[NSURL URLWithString:url] downLoadInfo:^(long long fileSize) {
        NSLog(@"fileSize--->%lld M",(fileSize/1024)/2014);
    } success:^(NSString * _Nonnull cacheFilePath) {
        NSLog(@"cacheFilePath--->%@",cacheFilePath);
    } failed:^{
        
    }];
}

-(void)testRouter{
   
    NSLog(@"name = %@,psd = %@",self.name,self.psd);
    NSLog(@"name = %@,psd = %@",self.user.name,self.user.psd);
    if (self.lhz_RouterBlock) {
        self.lhz_RouterBlock(self.name);
    }
    NSLog(@"===3");
    [LHZLoadingManager showTipsSuccess:@"跳转成功了..."];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [LHZLoadingManager showTipsSuccess:@"跳转返回了。。。"];
    [self.navigationController popViewControllerAnimated:YES];
    
    /*
     PSPlayerState state = [LHZPlayerManger manger].state;
     if (state == PSPlayerStatePlaying) {
     [[LHZPlayerManger manger] pause];
     }else {
     [[LHZPlayerManger manger] resume];
     }
    */
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
