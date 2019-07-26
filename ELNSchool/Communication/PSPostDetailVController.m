//
//  PSPostDetailVController.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/15.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSPostDetailVController.h"
#import "PSPinLunTableCell.h"
#import "JZTWritePingLunView.h"
#import "PSTableCell.h"
@interface PSPostDetailVController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) JZTWritePingLunView* writeView;
@end

@implementation PSPostDetailVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    [self configWriteView];
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
        [_tableView registerClass:[PSPinLunTableCell class] forCellReuseIdentifier:[PSPinLunTableCell cellID]];
        [_tableView registerClass:[PSTableCell class] forCellReuseIdentifier:[PSTableCell cellId]];
    }
    return _tableView;
}

#pragma mark --- writeView
-(void)configWriteView
{
    self.writeView =[[JZTWritePingLunView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    
    self.writeView.submitPingLunText = ^(NSString* text){
        NSLog(@"===%@",text);
        NSLog(@"length===%ld",text.length);
    };
}

#pragma mark  --- datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        PSPinLunTableCell* cell = [PSPinLunTableCell cellWithTable:tableView];
        cell.clickPLBlock = ^{
            
        };
        return cell;
    }
    
    
    PSTableCell* cell1 = [PSTableCell cellWithTable:tableView];
    return cell1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return [PSTableCell cellH];
    }
    return  UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view.window addSubview:self.writeView];
    [self.writeView beFirstResponder];
    if (self.writeView.hidden ==YES) {
        self.writeView.hidden =NO;
    }
}

@end
