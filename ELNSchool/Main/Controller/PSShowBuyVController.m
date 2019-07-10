//
//  PSShowBuyVController.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/10.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSShowBuyVController.h"
#import "PSPriceInfoTableCell.h"
#import "JZTPayCenter.h"
@interface PSShowBuyVController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIView* contentView;

@property(nonatomic,strong) UILabel* favoredPriceLab;

@property(nonatomic,strong) UILabel* tottalPriceLab;

@property(nonatomic,strong) UILabel* titleLab;

@property(nonatomic,strong) UITableView* tableView;
@end

@implementation PSShowBuyVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self initUI];
    
    [self addContentView];
}

-(void)initUI{
    UIView* contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.contentView = contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(kSafeBottomArea);
        make.height.mas_equalTo(KScreenHeight/2.0-40);
    }];
    
    UIButton* clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(contentView.mas_top);
    }];
}

-(void)addContentView{
    
    UILabel* titleLab = [[UILabel alloc] qmui_initWithFont:kFontBoldSize(15.0) textColor:UIColor.blackColor];
    [self.contentView addSubview:self.titleLab = titleLab];
    titleLab.text = @"终身学习 学海无涯";
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44.0);
    }];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10.0);
        make.height.mas_equalTo(44.0*2);
    }];
    
    UIButton* payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.backgroundColor = UIColor.redColor;
    [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(goToPay) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:payBtn];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(49.0);
    }];
    
    CGFloat leftSpcae = 15.0;
    
    UILabel* totalLab = [[UILabel alloc] qmui_initWithFont:kFontBoldSize(15.0) textColor:UIColor.blackColor];
    totalLab.text = @"共计";
    
    UILabel* tottalPriceLab = [[UILabel alloc] qmui_initWithFont:kFontSize(15.0) textColor:UIColor.redColor];
    tottalPriceLab.textAlignment = NSTextAlignmentRight;
    tottalPriceLab.text = @"¥199";
    
    UILabel* favoredPriceLab = [[UILabel alloc] qmui_initWithFont:kFontSize(13.0) textColor:UIColor.grayColor];
    favoredPriceLab.textAlignment = NSTextAlignmentRight;
    favoredPriceLab.text = @"优惠 ¥59";
    [self.contentView addSubViews:@[totalLab,
                    self.tottalPriceLab = tottalPriceLab,
                self.favoredPriceLab = favoredPriceLab]];
    
    [totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftSpcae);
        make.bottom.mas_equalTo(payBtn.mas_top).offset(-leftSpcae);
    }];
    
    [tottalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-leftSpcae);
        make.centerY.mas_equalTo(totalLab);
    }];
    
    [favoredPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-leftSpcae);
        make.bottom.mas_equalTo(tottalPriceLab.mas_top).offset(-15.0);
    }];
    
    UIView* centerLine = [[UIView alloc] init];
    centerLine.backgroundColor = UIColorFromRGB(0xf6f6f6);
    [self.contentView addSubview:centerLine];
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(totalLab);
        make.right.mas_equalTo(tottalPriceLab);
        make.height.mas_equalTo(1.0);
    make.bottom.mas_equalTo(favoredPriceLab.mas_top).offset(-15.0);
    }];
}

#pragma mark --- talble
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"PSPriceInfoTableCell" bundle:nil] forCellReuseIdentifier:@"PSPriceInfoTableCell"];
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PSPriceInfoTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PSPriceInfoTableCell"];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
}

#pragma mark ---- action
-(void)goToPay{
    NSLog(@"pay------");
    [JZTPayCenter payWithOrderID:@"" andResult:^(BOOL sucess) {
        
    }];
}

-(void)goBack{
    [self dismissViewControllerAnimated:NO completion:nil];
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
