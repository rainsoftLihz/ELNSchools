//
//  PSPinLunTableCell.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/15.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSPinLunTableCell.h"
@interface PSPinLunTableCell()
@property(nonatomic,strong) UIImageView* iconImg;
@property(nonatomic,strong) UILabel* nameLab;
@property(nonatomic,strong) UILabel* levelLab;
@property(nonatomic,strong) UILabel* contentLab;
@property(nonatomic,strong) LHZUIbutton* plBtn;
@property(nonatomic,strong) LHZUIbutton* dzBtn;
@end

@implementation PSPinLunTableCell

+(NSString*)cellID{
    return @"PSPinLunTableCell";
}

+(instancetype)cellWithTable:(UITableView*)table{
    PSPinLunTableCell* cell = [table dequeueReusableCellWithIdentifier:[self cellID]];
    if (!cell) {
        cell = [[PSPinLunTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellID]];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
        [self testD];
    }
    return self;
}

-(void)testD{
    _nameLab.text = @"张三";
    _levelLab.text = @"Lv.8 黄金";
    
    NSInteger flage = arc4random()%2;
    _contentLab.text = flage ==0 ? @"世界顶级服务评价俄批发价文件分配我就饿发脾气文件俄方将危旧房屋金额发危旧房屋我家佛教违法":@"四六级都将佛我就饿哦饭加我额将佛我饿饭";
    
    self.dzBtn.title = @"553";
}

-(void)configUI{
    
    _iconImg = [[UIImageView alloc] init];
  
    _nameLab = [[UILabel alloc] qmui_initWithFont:kFontSize(13.0) textColor:UIColor.blackColor];
    
    _levelLab = [[UILabel alloc] qmui_initWithFont:kFontSize(12.0) textColor:UIColor.whiteColor];
        _levelLab.backgroundColor = UIColor.orangeColor;
   
    _contentLab = [[UILabel alloc] qmui_initWithFont:kFontSize(13.0) textColor:UIColor.blackColor];
    _contentLab.numberOfLines = 0;
    
    
    _plBtn = [[LHZUIbutton alloc] initWith:kUIImage(@"huifu") and:@"评论"];
    [_plBtn addTarget:self action:@selector(goToPL) forControlEvents:UIControlEventTouchUpInside];
    
    _dzBtn = [[LHZUIbutton alloc] initWith:kUIImage(@"zx_dzNo") and:@"123"];

    
    [self.contentView addSubViews:@[_iconImg,_nameLab,_levelLab,_contentLab,_plBtn,_dzBtn]];
    
    [self layOutUI];
}

-(void)goToPL{
    if (self.clickPLBlock) {
        self.clickPLBlock();
    }
}

-(void)layOutUI{
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15.0);
        make.size.mas_equalTo(CGSizeMake(33.0, 33.0));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImg);
        make.left.mas_equalTo(self.iconImg.mas_right).offset(5.0);
    }];
    
    [self.levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLab);
        make.left.mas_equalTo(self.nameLab.mas_right).offset(5.0);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(5.0);
        make.left.mas_equalTo(self.nameLab).offset(0.0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10.0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    [self.dzBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10.0);
        make.centerY.mas_equalTo(self.nameLab);
    }];
    
    [self.plBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.dzBtn.mas_left).offset(-6.0);
        make.centerY.mas_equalTo(self.nameLab);
    }];
}


@end
