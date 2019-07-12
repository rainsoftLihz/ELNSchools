//
//  PSCommentTableCell.m
//  ELNSchool
//
//  Created by rainsoft on 2019/7/11.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSCommentTableCell.h"

@interface PSCommentTableCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *vipLogo;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *dzBtn;

@end

@implementation PSCommentTableCell

+(NSString*)cellID{
    return @"PSCommentTableCell";
}

+(PSCommentTableCell*)cellWithTable:(UITableView*)tableView{
    PSCommentTableCell* cell = [tableView dequeueReusableCellWithIdentifier:[PSCommentTableCell cellID]];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PSCommentTableCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
