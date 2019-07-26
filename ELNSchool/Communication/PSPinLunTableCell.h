//
//  PSPinLunTableCell.h
//  ELNSchool
//
//  Created by rainsoft on 2019/7/15.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSPinLunTableCell : UITableViewCell

+(NSString*)cellID;

+(instancetype)cellWithTable:(UITableView*)table;


@property(nonatomic,copy) void (^clickPLBlock)(void);

@end

NS_ASSUME_NONNULL_END
