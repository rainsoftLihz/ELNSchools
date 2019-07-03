//
//  PSCGIServer.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PSCGIConst.h"

#import "PSCGIManager.h"

@interface PSCGIServer : NSObject

+ (PSCGIManager*)CGIManagerWithMask:(PSCGIRequestMask)requestMask;

@end

