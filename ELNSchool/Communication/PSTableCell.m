//
//  PSTableCell.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/15.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSTableCell.h"
@interface PSTableCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView* tableView;
@end

@implementation PSTableCell

+(NSString*)cellId{
    return  @"PSTableCell";
}

+(instancetype)cellWithTable:(UITableView*)table{
    PSTableCell* cell = [table dequeueReusableCellWithIdentifier:[self cellId]];
    if (!cell) {
        cell = [[PSTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PSTableCell cellId]];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(30.0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15.0);
            make.top.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark --- table
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        _tableView.estimatedRowHeight = 44.0;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [self footer];
    }
    return _tableView;
}

-(UIView*)footer{
    UIView* foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 15)];
    foot.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return foot;
}

#pragma mark  --- datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [PSTableCell titleArr].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PSTableCell heightWithStr:[PSTableCell titleArr][indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = UIColor.groupTableViewBackgroundColor;
    }
    cell.textLabel.text = [PSTableCell titleArr][indexPath.row];
    cell.textLabel.font = kFontSize(13.0);
    cell.textLabel.numberOfLines = 0;
    return cell;
}



+(NSArray*)titleArr{
    return @[@"纪委将佛为哦妇女为哦发我额if我",@"数量将佛我就饿哦饭加我额陪我抛弃后更害怕害怕如果切厚片然后过人",@"哦就搜集佛教外婆额范围警方违反",@"我就饿佛教我额将佛违法",@"为了减肥我就饿发觉我额分",@"我额佛哦我就饿佛为",@"却惊愕批发价文件分配；违法物品和皮肤获取平衡我佩服和片尾曲很佩服害怕护肤品维护鹅湖额外澎湖湾何方违法为u护肤品为合法文化服务配护肤我佩服我",@"到家哦世界佛教为哦服务俄方文件发我额分我饿饭"];
}

+(CGFloat)cellH{
    CGFloat sumh = 0.0;
    for (int i = 0; i < [self titleArr].count; i++) {
        
        NSString* title = [self titleArr][i];
        
        sumh += [self heightWithStr:title];
    }
    return sumh+15;
}

+(CGFloat)heightWithStr:(NSString*)str{
    CGSize size = CGSizeMake(KScreenWidth-30-15, 2000);
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0]};
    
    CGFloat height = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height+5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
