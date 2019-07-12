//
//  PSCommentTableCell.h
//  ELNSchool
//
//  Created by rainsoft on 2019/7/11.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSCommentTableCell : UITableViewCell

+(NSString*)cellID;

+(PSCommentTableCell*)cellWithTable:(UITableView*)tableView;

@end

NS_ASSUME_NONNULL_END
