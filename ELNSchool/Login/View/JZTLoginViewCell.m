//
//  JZTLoginViewCell.m
//  JK_BLB
//
//  Created by rainsoft on 16/12/1.
//  Copyright © 2016年 com.JoinTown.jk998. All rights reserved.
//

#import "JZTLoginViewCell.h"

#import "JZTPhoneCodeButton.h"

#import "UIView+JZTCateGory.h"

#import "PSLoginAPI.h"

@interface JZTLoginViewCell()

@property (nonatomic,strong)UIImageView* iconImg;

@property (nonatomic,strong)UITextField* textFild;

@property (nonatomic,strong)JZTPhoneCodeButton* sendBtn;

/* 获取短信的时候需要改变它的位置 */
@property (nonatomic,strong)UIView* line;

/* 快速登录和重置密码不一样 */
@property (nonatomic,strong)NSString* messageType;

@end

@implementation JZTLoginViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self configUI];
    }
    return self;
}

+(CGFloat)cellHeight
{
    return 49;
}

#pragma mark -- 通用UI
-(void)configUI
{
    self.iconImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImg];
    
    self.textFild = [[UITextField alloc] init];
    self.textFild.borderStyle = UITextBorderStyleNone;
    self.textFild.font = [UIFont systemFontOfSize:16.0];
    self.textFild.textColor = UIColorFromRGB(0x4e4e4e);
    [self.textFild setValue:UIColorFromRGB(0xbebebe) forKeyPath:@"_placeholderLabel.textColor"];
    [self.textFild setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    [self.textFild addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:self.textFild];
    
    [self layoutUI];
}

-(void)setUIWithIconStr:(NSString*)imgStr andPlaceHolderStr:(NSString*)placeHolder
{
    if (imgStr.length == 0) {
        return;
    }
    
    self.iconImg.image = [UIImage imageNamed:imgStr];
    
    self.textFild.placeholder = placeHolder;
}

-(void)configTextFild:(NSString*)text
{
    if (text.length == 0) {
        return;
    }
    self.textFild.text = text;
}

-(void)needSecretInput
{
    self.textFild.secureTextEntry = YES;
}

#pragma mark --- 手机号的特殊处理
-(void)changeInputKeyBoard
{
    self.textFild.keyboardType = UIKeyboardTypeNumberPad;
    self.textFild.clearButtonMode = UITextFieldViewModeAlways;
}

-(void)changeTextfildUserInteraction:(BOOL)enabled
{
    self.textFild.userInteractionEnabled = enabled;
}

-(JZTPhoneCodeButton *)sendBtn
{
    if (_sendBtn == nil) {
        _sendBtn = [JZTPhoneCodeButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn.layer setBorderWidth:1];
        [_sendBtn.layer setCornerRadius:3];
        _sendBtn.backgroundColor = [UIColor whiteColor];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_sendBtn setTitleColor:UIColorFromRGB(0x4e4e4e) forState:UIControlStateNormal];
        [_sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

#pragma mark --- 按需添加获取验证码的按钮
-(void)addSendMessageBtnWithType:(NSString*)messageType
{
    self.messageType = messageType;
    
    [self.contentView addSubview:self.sendBtn];

    [self.sendBtn setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.sendBtn setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = UIColorFromRGB(0xbebebe);
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImg.mas_top).offset(-2.5);
        make.bottom.mas_equalTo(self.iconImg.mas_bottom).offset(2.5);
        make.width.mas_equalTo(1.0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-106);
        /* 倒计时的时候间距一直在变 */
        //make.right.mas_equalTo(self.sendBtn.mas_left).offset(-8.0);
    }];
    self.line = line;
    
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-75*kWProportion);
        make.centerY.mas_equalTo(self.iconImg.mas_centerY);
        make.left.mas_equalTo(self.line.mas_right).offset(8.0);
        make.height.mas_equalTo(self.iconImg);
    }];
    
    [self.textFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(line.mas_left).offset(-8);
    }];
}

#pragma mark -- 获取验证码
-(void)getVerifyCode
{
    if (self.textFild.text.length == 0) {
        NSLog( @"请输入手机号");
        return;
    }
    
    if (![Utils validateMobile:self.textFild.text]) {
        NSLog( @"请输入正确的手机号!");
        return;
    }
    
    [self.sendBtn startUpTimerWithDurationToValidity:60];
    
    NSString* md5Str = [NSString stringWithFormat:@"%@%@",self.textFild.text,MD5_SCRECT_CODE];
  

}

-(void)layoutUI
{
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(106*kWProportion);
        make.top.mas_equalTo(self.contentView).offset(69*kHProportion);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.textFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImg.mas_right).offset(54*kWProportion);
        make.top.mas_equalTo(self.iconImg.mas_top).offset(-40*kHProportion);
        make.bottom.mas_equalTo(self.iconImg.mas_bottom).offset(40*kHProportion);
        make.width.mas_equalTo(250);
    }];
}

-(void)textFieldDidChanged:(UITextField*)textF
{
    
    if ([textF.placeholder containsString:@"手机号"]) {
        //手机号截断处理
        if (textF.text.length >= 11) {
            textF.text = [textF.text substringToIndex:11];
        }
    }
    
    else {
        //密码最大14位
        if (textF.text.length >= 14) {
            textF.text = [textF.text substringToIndex:14];
        }
    }
    
    if (self.backText) {
        self.backText(textF.text);
    }
}

@end
