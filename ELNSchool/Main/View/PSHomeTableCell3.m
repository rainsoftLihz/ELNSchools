//
//  PSHomeTableCell3.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/8.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSHomeTableCell3.h"

@interface PSHomeTableCell3()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titelLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceRightLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLeftLab;

@end

@implementation PSHomeTableCell3

+(NSString*)cellID{
    return @"PSHomeTableCell3";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)addBottomLine{
    //分割线
    UIView* spaceLine = [[UIView alloc] init];
    spaceLine.backgroundColor =  UIColor.groupTableViewBackgroundColor;
    [self.contentView addSubview:spaceLine];
    [spaceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
