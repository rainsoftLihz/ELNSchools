       //
//  JZTLoginBaseVC.m
//  JK_BLB
//
//  Created by rainsoft on 16/12/1.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import "JZTLoginBaseVC.h"


#import "Utils.h"

#import "JZTLoginViewCell.h"


@interface JZTLoginBaseVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation JZTLoginBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configBackItem];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(CGFloat)topSpace
{
    return 527*kHProportion;
}

-(CGFloat)headerTopSpace
{
    return 321*kHProportion;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [self topSpace], KScreenWidth, self.iconArr.count*[JZTLoginViewCell cellHeight])];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        [_tableView  setSeparatorColor:UIColorFromRGB(0xe5e5e5)];
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}


#pragma mark ---   返回按钮
-(void)configBackItem
{
    
    UIButton* clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(0, 20.0, 100, 44);
    [clearBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"byj_fanhui"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(12.0, 44/2.0-21/2.0, 21, 21);
    backBtn.userInteractionEnabled = NO;
    [clearBtn addSubview:backBtn];
    
}

-(void)goBack:(UIButton*)senderBtn
{
    [self.view endEditing:YES];
    /* 防止重复点击 */
    senderBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        senderBtn.enabled = YES;
    });

}

#pragma mark --- tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.iconArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JZTLoginViewCell cellHeight];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JZTLoginViewCell* cell = [[JZTLoginViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [cell setUIWithIconStr:self.iconArr[indexPath.row] andPlaceHolderStr:self.placeHolderArr[indexPath.row]];
    
    [self configCell:cell andIndexPath:indexPath];
    
    return cell;
}


-(void)configCell:(JZTLoginViewCell*)cell andIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark --- table下面的大按钮
-(void)configBottomActionBtnWithTitle:(NSString*)title
{
    CGFloat leftSpace = 15;
    CGFloat height = 127/3.0;
    
    UIButton* submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(leftSpace,self.tableView.bottom+50, KScreenWidth-2*leftSpace, height);
    [submitBtn setTitle:title forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    submitBtn.backgroundColor = UIColor.redColor;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.tag = 1111;
    [submitBtn addTarget:self action:@selector(bottomBigBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:submitBtn];
}

-(void)bottomBigBtnClick
{
    
}

-(void)configHeaderWith:(NSString*)title
{
    UILabel* titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(0, [self headerTopSpace], KScreenWidth, 88*kHProportion);
    titleLab.font = [UIFont boldSystemFontOfSize:17.0];
    titleLab.textColor = UIColor.blackColor;
    titleLab.text = title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
}

#pragma mark --- 登录
-(void)loginWithDic:(NSDictionary*)paramsDic
{

}


#pragma mark --- 登陆成功
-(void)saveAccout:(NSString*)accout andPasswd:(NSString*)Passwd
{
    //保存账号
    [Utils savaAccount:accout];
    [Utils savaPassWord:Passwd];
}

- (void)successLoginCallBack:(NSDictionary *)dict back:(BOOL)isBack{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
