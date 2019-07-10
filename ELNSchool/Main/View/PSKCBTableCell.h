//
//  PSKCBTableCell.h
//  ELNSchool
//
//  Created by rainsoft on 2019/7/10.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSKCBTableCell : UITableViewCell
+(NSString*)cellID;
+(PSKCBTableCell*)cellWithTable:(UITableView*)tableView;
@end

NS_ASSUME_NONNULL_END
