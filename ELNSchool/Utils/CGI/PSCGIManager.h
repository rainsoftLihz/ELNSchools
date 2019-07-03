//
//  PSCGIManager.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "PSCGIConst.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSCGIManager : AFHTTPSessionManager

@property (nonatomic,assign) PSCGIRequestMask requestMask;

- (instancetype)initWithBaseURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
