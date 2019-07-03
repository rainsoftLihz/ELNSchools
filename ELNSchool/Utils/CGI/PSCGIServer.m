//
//  PSCGIServer.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/9.
//  Copyright © 2019年 jzt. All rights reserved.
//

#import "PSCGIServer.h"

@implementation PSCGIServer
+ (PSCGIManager*)CGIManagerWithMask:(PSCGIRequestMask)requestMask
{
    PSCGIManager *manager = nil;
    
    switch (requestMask) {

        case PSCGIRequestMaskDefult:
        {
            manager = [[PSCGIManager alloc] initWithBaseURL:[NSURL URLWithString:kApi_Base_Url]];
            break;
        }
        
        default:
        {
            manager = [[PSCGIManager alloc] initWithBaseURL:[NSURL URLWithString:kApi_Base_Url]];
            break;
        }
    }
    manager.requestSerializer.timeoutInterval = 30;
    manager.requestMask = requestMask;
    return manager;
}

@end
