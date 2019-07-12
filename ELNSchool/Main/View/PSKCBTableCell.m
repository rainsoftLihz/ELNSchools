//
//  PSKCBTableCell.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/10.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSKCBTableCell.h"
@interface PSKCBTableCell()
@property(nonatomic,strong) UIImageView* imgV;
@property(nonatomic,strong) UILabel* topLab;
@property(nonatomic,strong) UILabel* centerLab;
@property(nonatomic,strong) UILabel* bottomLab;
@end
@implementation PSKCBTableCell

+(NSString*)cellID{
    return @"PSKCBTableCell";
}

+(PSKCBTableCell*)cellWithTable:(UITableView*)tableView{
     PSKCBTableCell* cell = [tableView dequeueReusableCellWithIdentifier:[PSKCBTableCell cellID]];
    if (!cell) {
        cell = [[PSKCBTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PSKCBTableCell cellID]];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)configUI{
    
    self.imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"classroom_daily_lesson"]];
    [self.contentView addSubViews:@[self.imgV,self.topLab,self.centerLab,self.bottomLab]];
    
    NSInteger idex = arc4random()%2;
    self.topLab.text = idex==0 ? @"到家哦睡觉哦大家佛世界，这个可以排列为2行":@"这个1行就够了";
    self.centerLab.text = @"四季豆惊悚的";
    self.bottomLab.text = @"VIP免费";
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.0);
        make.top.mas_equalTo(5.0);
        make.bottom.mas_equalTo(-5.0);
        make.width.mas_equalTo(100);
    }];
    
    [self.topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgV);
        make.left.mas_equalTo(self.imgV.mas_right).offset(5.0);
        make.right.mas_equalTo(self.contentView).offset(-15.0);
    }];
    
    [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.topLab);
        make.bottom.mas_equalTo(self.imgV);
    }];
    
    [self.centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.topLab);
        make.top.mas_equalTo(self.topLab.mas_bottom);
        make.bottom.mas_equalTo(self.bottomLab.mas_top);
    }];
    
    
}




-(UILabel *)topLab{
    if (!_topLab) {
        _topLab = [[UILabel alloc] qmui_initWithFont:kFontSize(14.0) textColor:UIColor.blackColor];
        _topLab.numberOfLines = 0;
    }
    return _topLab;
}

-(UILabel *)centerLab{
    if (!_centerLab) {
        _centerLab = [[UILabel alloc] qmui_initWithFont:kFontBoldSize(13.0) textColor:UIColor.grayColor];
    }
    return _centerLab;
}

-(UILabel *)bottomLab{
    if (!_bottomLab) {
        _bottomLab = [[UILabel alloc] qmui_initWithFont:kFontSize(13.0) textColor:UIColor.redColor];
    }
    return _bottomLab;
}

@end
