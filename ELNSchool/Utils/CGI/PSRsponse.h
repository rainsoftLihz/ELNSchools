//
//  PSRsponse.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSRsponse : NSObject

//状态码
@property (nonatomic,copy)NSString* ret;

//提示信息
@property (nonatomic,copy)NSString* msg;

// 数据
@property (nonatomic, strong) id data;

@property (nonatomic, strong)NSString* err_msg;

@property (nonatomic, strong)NSString* err_code;

@end

NS_ASSUME_NONNULL_END
