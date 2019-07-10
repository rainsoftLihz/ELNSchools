//
//  PSBuyToolView.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/10.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBuyToolView.h"
@interface PSBuyToolView()
@property(nonatomic,strong) UILabel* vipPriceLab;
@property(nonatomic,strong) UILabel* comPriceLab;
@property(nonatomic,strong) UIButton* buyBtn;
@property (nonatomic,copy)ShowBuyBlock block;
@end

@implementation PSBuyToolView

-(instancetype)initWithFrame:(CGRect)frame andShowBuyAction:(ShowBuyBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.block = block;
        [self configUI];
        [self setUIWith:nil];
    }
    return self;
}

-(void)configUI{
    
    self.backgroundColor = UIColor.whiteColor;
    
    [self addSubViews:@[self.vipPriceLab,self.comPriceLab,self.buyBtn]];
    
    [self.vipPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self);
        make.width.mas_equalTo(KScreenWidth/3.0);
    }];
    
    [self.comPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(self);
        make.width.mas_equalTo(KScreenWidth/3.0);
    }];
    
    
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = UIColor.grayColor;
    [self.comPriceLab addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.comPriceLab);
        make.height.mas_equalTo(1.0);
        make.centerY.mas_equalTo(self.comPriceLab);
    }];
}

-(void)setUIWith:(id)model{
    self.vipPriceLab.text = @"VIP ¥158";
    self.comPriceLab.text = @"原价 319";
}

#pragma mark  --- lazy init
-(UILabel *)vipPriceLab{
    if (!_vipPriceLab) {
        _vipPriceLab = [[UILabel alloc] qmui_initWithFont:kFontSize(14.0) textColor:UIColor.orangeColor];
        _vipPriceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _vipPriceLab;
}

-(UILabel *)comPriceLab{
    if (!_comPriceLab) {
        _comPriceLab = [[UILabel alloc] qmui_initWithFont:kFontSize(14.0) textColor:UIColor.blackColor];
        _comPriceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _comPriceLab;
}

-(UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setTitle:@"购买课程" forState:UIControlStateNormal];
        [_buyBtn setBackgroundColor:UIColor.redColor];
        [_buyBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = kFontSize(14.0);
        [_buyBtn addTarget:self action:@selector(goBuy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

#pragma mark  --- 购买
-(void)goBuy{
    if (self.block) {
        self.block();
    }
}

@end
