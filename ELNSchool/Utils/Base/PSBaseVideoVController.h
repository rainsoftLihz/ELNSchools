//
//  PSBaseVideoVController.h
//  ELNSchool
//
//  Created by rainsoft on 2019/6/12.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSBaseVideoVController : PSBaseViewController

-(instancetype)initWith:(BOOL)autoPlay and:(NSString*)url;

-(instancetype)initWith:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
