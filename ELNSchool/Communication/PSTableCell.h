//
//  PSTableCell.h
//  ELNSchool
//
//  Created by rainsoft on 2019/7/15.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSTableCell : UITableViewCell
+(NSString*)cellId;

+(instancetype)cellWithTable:(UITableView*)table;

+(CGFloat)cellH;
@end

NS_ASSUME_NONNULL_END
