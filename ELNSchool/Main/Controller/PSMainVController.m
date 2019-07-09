//
//  PSMainVController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSMainVController.h"
#import "PSHomeModel.h"
#import "PSHomeAPI.h"
#import "PSHomeHeaderView.h"
#import "PSTestViewController.h"
#import "PSHomeTableCell1.h"
#import "PSHomeTableCell2.h"
#import "PSHomeTableCell3.h"
@interface PSMainVController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* tableView;

@property (nonatomic,strong)PSHomeHeaderView* headerView;

@end

@implementation PSMainVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    NSLog(@"kISIphoneX === %d",kISIphoneX);
    
    [self.view addSubview:self.tableView];
    
    _headerView = [[PSHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Adapt_scaleV(250))];
    self.tableView.tableHeaderView = _headerView;
    _headerView.block = ^{
        
    
    };
    
    [self.headerView setUpUIwiht:nil];
    
    //[self reqData];
}



-(void)reqData{

    [LHZLoadingManager showLoading:@"数据加载中..."];
    
    [PSHomeAPI getHomeDataSuccess:^(NSURLSessionDataTask *task, id response) {
        [SVProgressHUD dismiss];
        PSRsponse* res = (PSRsponse*)response;
        PSHomeModel* model = res.data;
        //[self.headerView setUpUIwiht:model];
    } faile:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];;
        //[self.collectionView reloadData];
    }];
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
        _tableView.estimatedRowHeight = 99.0;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PSHomeTableCell1 class] forCellReuseIdentifier:[PSHomeTableCell1 cellID]];
        [_tableView registerNib:[UINib nibWithNibName:@"PSHomeTableCell3" bundle:nil] forCellReuseIdentifier:[PSHomeTableCell3 cellID]];
    }
    return _tableView;
}


#pragma mark --- datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 10;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PSHomeTableCell1* cell = [PSHomeTableCell1 cellWithTableview:tableView];
        return cell;
    }
    
    PSHomeTableCell3* cell3 = [tableView dequeueReusableCellWithIdentifier:[PSHomeTableCell3 cellID]];
    return  cell3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [PSHomeTableCell1 cellHight];
    }
    return UITableViewAutomaticDimension;
}


#pragma mark --- footer header

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44.0;
    }
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 4.0;
    }
    return CGFLOAT_MIN;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel* headerLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44.0)];
    headerLab.font = [UIFont systemFontOfSize:14.0];
    headerLab.backgroundColor = UIColor.whiteColor;
    headerLab.text = @" 精品课程";
    return headerLab;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 4.0)];
    footer.backgroundColor = UIColor.groupTableViewBackgroundColor;
    return footer;
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
