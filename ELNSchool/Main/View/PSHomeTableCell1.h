//
//  PSHomeTableCell1.h
//  ELNSchool
//
//  Created by rainsoft on 2019/7/8.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSHomeTableCell1 : UITableViewCell

+(NSString*)cellID;

+(CGFloat)cellHight;

+(PSHomeTableCell1*)cellWithTableview:(UITableView*)tableview;

@end

NS_ASSUME_NONNULL_END
