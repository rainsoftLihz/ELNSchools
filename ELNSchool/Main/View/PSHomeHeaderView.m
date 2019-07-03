//
//  PSHomeHeaderView.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSHomeHeaderView.h"
#import "PSProgressView.h"
@interface PSHomeHeaderView()
@property(nonatomic,strong) PSProgressView *progressView;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong)UILabel *countTimeLabel;

@property(nonatomic,strong)UIButton* signBtn;

@property(nonatomic,strong)UILabel *punchCardLabel;
@property(nonatomic,strong)UILabel *getNumberLabel;
@property(nonatomic,strong)UILabel *titllLabel;
@end
@implementation PSHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景色
        [self addGradientColor];
        
        [self initUI];
    }
    return self;
}

- (void)setUpUIwiht:(PSHomeModel*)model{
    _countTimeLabel.text = [NSString stringWithFormat:@"学习目标时长%@分钟",model.aimStudyTime];
    _titllLabel.text = [NSString stringWithFormat:@"%ld",(long)model.hasStudyTime];
    _punchCardLabel.text = [NSString stringWithFormat:@"%ld\n累计打卡",(long)model.signTotalCount];
    _getNumberLabel.text = [NSString stringWithFormat:@"%ld\n已获学豆",(long)model.totalCoin];
    
    
    [self addSubview:self.progressView];
    _progressView.num = 30;//model.hasStudyTime;
    _progressView.countNum = 55;//[model.aimStudyTime intValue];
    
}



- (void)initUI {

    [self addSubViews:@[self.titllLabel,self.timeLabel,self.countTimeLabel,self.signBtn]];
    
    [self.titllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(Adapt_scaleV(60.0));
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
        
    }];
  
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titllLabel.mas_bottom).offset(Adapt_scaleV(10));
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(Adapt_scaleV(30));
        
    }];

    [self.countTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(Adapt_scaleV(12));
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(Adapt_scaleV(25));
        
    }];
    
    
    [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countTimeLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView addSubViews:@[self.punchCardLabel,self.getNumberLabel]];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        //make.height.mas_equalTo(50);
        make.top.equalTo(self.signBtn.mas_bottom).offset(8.0);
    }];
    
    [bottomView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [bottomView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bottomView);
    }];
    
}

#pragma mark --- lazy load
//进度条
-(PSProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[PSProgressView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, Adapt_scaleV(150))];
        _progressView.backgroundColor = [UIColor clearColor];
    }
    return _progressView;
}

-(UILabel *)titllLabel{
    if (!_titllLabel) {
        _titllLabel = [[QMUILabel alloc] qmui_initWithFont: [UIFont systemFontOfSize:17] textColor:[UIColor groupTableViewBackgroundColor]];
        _titllLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titllLabel;
}

//学习目标时长
-(UILabel *)countTimeLabel{
    if (!_countTimeLabel) {
        _countTimeLabel = [[QMUILabel alloc] qmui_initWithFont: [UIFont systemFontOfSize:17] textColor:[UIColor whiteColor]];
        _countTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countTimeLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[QMUILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:17.0] textColor:UIColor.whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

-(UIButton *)signBtn{
    if (!_signBtn) {
        UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [signBtn setTitle:@"打卡" forState:0];
        signBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [signBtn addTarget:self action:@selector(signBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        signBtn.layer.cornerRadius = 14;
        signBtn.layer.masksToBounds = YES;
        signBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        signBtn.layer.borderWidth = 1;
        _signBtn = signBtn;
    }
    return  _signBtn;
}

//累计打卡
-(UILabel *)punchCardLabel{
    if (!_punchCardLabel) {
        _punchCardLabel = [[QMUILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:14.0] textColor:UIColor.grayColor];
        _punchCardLabel.textAlignment = NSTextAlignmentCenter;
        _punchCardLabel.numberOfLines = 0;
    }
    return _punchCardLabel;
}

//已获学豆
-(UILabel *)getNumberLabel{
    if (!_getNumberLabel) {
        _getNumberLabel = [[QMUILabel alloc] qmui_initWithFont:[UIFont systemFontOfSize:14.0] textColor:UIColor.grayColor];
        _getNumberLabel.textAlignment = NSTextAlignmentCenter;
        _getNumberLabel.numberOfLines = 0;
    }
    return _getNumberLabel;
}


#pragma mark --- 签到
- (void)signBtnEvent:(UIButton *)btn {
    if (self.block) {
        self.block();
    };
}


@end
