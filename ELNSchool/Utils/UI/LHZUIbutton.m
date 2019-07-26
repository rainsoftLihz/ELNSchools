//
//  LHZUIbutton.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/10.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "LHZUIbutton.h"
@interface LHZUIbutton()

@property(nonatomic,strong) UIImageView* imgV;

@property(nonatomic,strong) UILabel* titleLab;

@end
@implementation LHZUIbutton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //默认间距
        self.space = 3.0;
        self.enabled = YES;
        [self configUI];
    }
    return self;
}

-(instancetype)initWith:(UIImage*)image and:(NSString*)title{
    if (self = [super initWithFrame:CGRectZero]) {
        //默认间距
        self.space = 3.0;
        self.enabled = YES;
        [self configUI];
        
        self.image = image;
        self.title = title;
    }
    return self;
}

-(void)configUI{
    
    UIImageView* imgv = [[UIImageView alloc] init];
    [self addSubview:self.imgV = imgv];

    UILabel* lab = [[UILabel alloc] qmui_initWithFont:kFontSize(14.0) textColor:UIColor.blackColor];
    [self addSubview:self.titleLab = lab];

    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_equalTo(self);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.imgV.mas_right).offset(self.space);;
    }];
}


#pragma mark  --- setter
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLab.text = title;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imgV.image = image;
}

@end
