//
//  PSSocialTableCell.h
//  ELNSchool
//
//  Created by rainsoft on 2019/7/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSSocialTableCell : UITableViewCell
@property (copy, nonatomic) void (^photoViewChangeHeightBlock)(UITableViewCell *myCell, CGFloat photoViewHegith);

+(NSString*)cellID;

+(PSSocialTableCell*)cellWithTable:(UITableView*)tableView;

@end

NS_ASSUME_NONNULL_END
