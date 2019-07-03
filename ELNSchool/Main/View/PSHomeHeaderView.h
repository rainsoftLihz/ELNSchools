//
//  PSHomeHeaderView.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSHomeModel.h"
typedef void(^SignBlock)(void);

@interface PSHomeHeaderView : UIImageView
//签到
@property (nonatomic,copy)SignBlock block;


- (void)setUpUIwiht:(PSHomeModel*)model;

@end

