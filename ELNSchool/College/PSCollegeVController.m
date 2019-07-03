//
//  PSCollegeVController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSCollegeVController.h"
#import "PSDocmentPreviewController.h"
#import "PSBaseWebVController.h"
@interface PSCollegeVController ()

@end

@implementation PSCollegeVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    PSDocmentPreviewController* web = [[PSDocmentPreviewController alloc] initWith:@"https://www.tutorialspoint.com/ios/ios_tutorial.pdf"];
    [self.navigationController pushViewController:web animated:YES];
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
