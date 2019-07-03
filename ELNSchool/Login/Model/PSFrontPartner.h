//
//  PSFrontPartner.h
//  PacificSchool
//
//  Created by rainsoft on 2019/6/6.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSFrontPartner : NSObject
@property(nonatomic,strong) NSString* coopCode;
@property(nonatomic,strong) NSString* partnerId;
@property(nonatomic,strong) NSString* partnerName;
@property(nonatomic,strong) NSString* partnerNo;

@property(nonatomic,strong) NSString* accessToken;
@property(nonatomic,strong) NSString* frontUserId;
@property(nonatomic,strong) NSString* nickname;
@end

NS_ASSUME_NONNULL_END
