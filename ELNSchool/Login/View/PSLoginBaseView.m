//
//  PSLoginBaseView.m
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSLoginBaseView.h"


@interface PSLoginBaseView()

@property (nonatomic,strong)UIImageView* iconImg;

@property (nonatomic,strong)UITextField* textFild;

@property (nonatomic,strong)NSString* iconName;

@property (nonatomic,strong)NSString* placeholdStr;

@property (nonatomic,copy)TextBack textBack;
@end


@implementation PSLoginBaseView

-(instancetype)initWithFrame:(CGRect)frame andIcon:(NSString*)iconName andPlacehold:(NSString*)placeholdStr andBlock:(TextBack)block{
    if (self = [super initWithFrame:frame]) {
        self.iconName = iconName;
        self.placeholdStr = placeholdStr;
        self.textBack = block;
        [self configUI];
    }
    return self;
}

#pragma mark -- 通用UI
-(void)configUI
{
    self.iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.iconName]];
    [self addSubview:self.iconImg];
    
    self.textFild = [[UITextField alloc] init];
    self.textFild.borderStyle = UITextBorderStyleNone;
    self.textFild.font = [UIFont systemFontOfSize:16.0];
    self.textFild.textColor = UIColorFromRGB(0x4e4e4e);
    self.textFild.placeholder = self.placeholdStr;
    [self.textFild setValue:UIColorFromRGB(0xbebebe) forKeyPath:@"_placeholderLabel.textColor"];
    [self.textFild setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    [self.textFild addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.textFild];
    self.textFild.keyboardType = UIKeyboardTypeNumberPad;
    [self layoutUI];
}

-(void)layoutUI
{
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(106*kWProportion);
        make.top.mas_equalTo(self).offset(69*kHProportion);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.textFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImg.mas_right).offset(54*kWProportion);
        make.top.mas_equalTo(self.iconImg.mas_top).offset(-40*kHProportion);
        make.bottom.mas_equalTo(self.iconImg.mas_bottom).offset(40*kHProportion);
            make.right.mas_equalTo(self).offset(-106*kWProportion);
    }];
}

-(void)textFieldDidChanged:(UITextField*)textField{
    
    if (textField.text.length >= 11) {
        textField.text = [textField.text substringToIndex:11];
    }
    
    if (self.textBack) {
        self.textBack(textField.text);
    }
}

@end
