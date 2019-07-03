//
//  PSTestViewController.h
//  ELNSchool
//
//  Created by rainsoft on 2019/6/25.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface UserInfo : NSObject

@property(nonatomic,strong) NSString* name;

@property(nonatomic,strong) NSString* psd;

@end

@interface PSTestViewController : PSBaseViewController

@property(nonatomic,strong) NSString* name;

@property(nonatomic,strong) NSString* psd;

@property(nonatomic,strong) UserInfo* user;

@end

NS_ASSUME_NONNULL_END
