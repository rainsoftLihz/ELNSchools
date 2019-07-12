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
#import "PSSocialTableCell.h"
@interface PSCollegeVController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* tableView;

@end

@implementation PSCollegeVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}


#pragma mark --- table
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        _tableView.estimatedRowHeight = 199.0;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PSSocialTableCell class] forCellReuseIdentifier:[PSSocialTableCell cellID]];
    }
    return _tableView;
}


#pragma mark --- datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSSocialTableCell* cell3 = [PSSocialTableCell cellWithTable:tableView];
    cell3.photoViewChangeHeightBlock = ^(UITableViewCell * _Nonnull myCell, CGFloat photoViewHegith) {
        NSLog(@"reload------");
        [tableView reloadData];
    };
    return  cell3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewAutomaticDimension;
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
